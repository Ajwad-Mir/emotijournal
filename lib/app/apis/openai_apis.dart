import 'dart:convert';
import 'dart:developer';

import 'package:emotijournal/app/configs/api_configs.dart';
import 'package:emotijournal/app/models/journal_response_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JournalAI {
  JournalAI._();
  static final apiKey = "".obs;

  static Future<void> fetchApiKey() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 0), // Change to hours in production
    ));

    await remoteConfig.fetchAndActivate();

    apiKey.value = remoteConfig.getString('google_ai_api_key');
  }

  static Future<JournalResponseModel> getFirstResponse(String query) async {
    final response = await http.post(
      Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${apiKey.value}"),
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
      log(result.toString());
      return JournalResponseModel.fromJson(result);
    }
    return JournalResponseModel.empty();
  }

  static Future<JournalResponseModel> getImprovedResponse(String query) async {
    final response = await http.post(
        Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${apiKey.value}"),
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
    log(response.body.toString());
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final cleanedString = convertJsonResponse(data['candidates'][0]['content']['parts'][0]['text']);
      log(cleanedString);
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
