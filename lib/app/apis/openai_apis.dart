import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class JournalAI {
  JournalAI._();

  static String apiKey = "";

  static Future<void> initialize() async {
    await dotenv.load(fileName: 'keys.env');
    apiKey = dotenv.get("GOOGLE_AI_API_KEY", fallback: "");
  }

  static Future<void> getFirstResponse(String query) async {
    final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey"),
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": "I want you to analyze the user's feelings through the input, understand it and generate your understanding as well your solution for it to how the user can solve it saying you instead of the user, emotions list with basic emotions and some quotes that can match the user's feelings. quote and it's author should be separated. also each user query should be stored like this {query and solution}. there can be multiple queries in a list. emotions and quotes are outside queries and should be global. The final result must be in JSON format"
              },
              {
                "text": query,
              }
            ]
          }
        ]
      }),
      headers: {
        'Content-Type': 'application/json',
      }
    );
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      log(data.toString());
      final cleanedString = convertJsonResponse(data['candidates'][0]['content']['parts'][0]['text']);
      final result = jsonDecode(cleanedString);
      log(result.toString());
    }
  }

  static String convertJsonResponse(String response) {
    String jsonString = response.replaceAll('```json', '').replaceAll('```', '').trim();
    return jsonString;
  }
}
