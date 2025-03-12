import 'dart:convert';
import 'package:emotijournal/app/configs/api_configs.dart';
import 'package:emotijournal/app/models/journal_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class JournalAI {
  JournalAI._();

  static Future<JournalResponseModel> getFirstResponse(String query) async {
    final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${ApiConfigs.googleAiApiKey}"),
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": ApiConfigs.apiQuery,
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
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${ApiConfigs.apiQuery}"),
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": ApiConfigs.improvementApiQuery,
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
