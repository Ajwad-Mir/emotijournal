import 'dart:convert';
import 'package:emotijournal/app/models/journal_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class JournalAI {
  JournalAI._();

  static String apiKey = "";
  static String initialQuery = "";
  static String improvementQuery = "";

  static Future<void> initialize() async {
    await dotenv.load(fileName: 'keys.env');
    apiKey = dotenv.get("GOOGLE_AI_API_KEY", fallback: "");
    initialQuery = dotenv.get("API_QUERY", fallback: "");
    improvementQuery = dotenv.get("IMPROVEMENT_API_QUERY", fallback: "");

  }

  static Future<JournalResponseModel> getFirstResponse(String query) async {
    final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey"),
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": initialQuery,
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
      final cleanedString = convertJsonResponse(data['candidates'][0]['content']['parts'][0]['text']);
      final result = jsonDecode(cleanedString) as Map<String,dynamic>;
      return JournalResponseModel.fromJson(result);
    }
    return JournalResponseModel.empty();
  }

  static Future<JournalResponseModel> getImprovedResponse(String query) async {
    final response = await http.post(
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey"),
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": improvementQuery,
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
      final cleanedString = convertJsonResponse(data['candidates'][0]['content']['parts'][0]['text']);
      final result = jsonDecode(cleanedString) as Map<String,dynamic>;
      return JournalResponseModel.fromJson(result);
    }
    return JournalResponseModel.empty();
  }

  static String convertJsonResponse(String response) {
    String jsonString = response.replaceAll('```json', '').replaceAll('```', '').trim();
    return jsonString;
  }
}
