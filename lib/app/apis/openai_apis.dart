import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:emotijournal/app/configs/api_configs.dart';
import 'package:emotijournal/app/models/journal_response_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class JournalAI {
  JournalAI._();

  static final apiKey = "".obs;

  static Future<void> fetchApiKey() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval:
          const Duration(seconds: 0), // Change to hours in production
    ));

    await remoteConfig.fetchAndActivate();

    apiKey.value = remoteConfig.getString('google_ai_api_key');
  }

  static Future<JournalResponseModel> getFirstResponse(String query) async {
    print(apiKey.value);
    final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey.value,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          requiredProperties: ["title", "queries", "emotions", "quotes"],
          properties: {
            "title": Schema(
              SchemaType.string,
            ),
            "queries": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["query", "solution", "timestamp"],
                properties: {
                  "query": Schema(
                    SchemaType.string,
                  ),
                  "solution": Schema(
                    SchemaType.string,
                  ),
                  "timestamp": Schema(
                    SchemaType.string,
                  ),
                },
              ),
            ),
            "emotions": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["emotion", "percentage", "colorHex"],
                properties: {
                  "emotion": Schema(
                    SchemaType.string,
                  ),
                  "percentage": Schema(
                    SchemaType.integer,
                  ),
                  "colorHex": Schema(
                    SchemaType.string,
                  ),
                },
              ),
            ),
            "quotes": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["quote", "author"],
                properties: {
                  "quote": Schema(
                    SchemaType.string,
                  ),
                  "author": Schema(
                    SchemaType.string,
                  ),
                },
              ),
            ),
          },
        ),
      ),
    );

    final chat = model.startChat(history: [
      Content.multi([
        TextPart(
          ApiConfigs.apiQuery,
        ),
      ]),
      Content.model([
        TextPart(
            '{\n  "emotions": [\n    {\n      "colorHex": "#FF0000",\n      "emotion": "Fear",\n      "percentage": 40\n    },\n    {\n      "colorHex": "#FFA500",\n      "emotion": "Anxiety",\n      "percentage": 30\n    },\n    {\n      "colorHex": "#800080",\n      "emotion": "Confusion",\n      "percentage": 30\n    }\n  ],\n  "queries": [\n    {\n      "query": "I have been feeling conflicted between staying in my comfort zone and trying something new. I acknowledged the fear for it but it is still being mentally disturbing for me",\n      "solution": "It\'s understandable that you are feeling conflicted. To navigate this, you should try breaking down the \'something new\' into smaller, manageable steps. This can reduce the feeling of being overwhelmed. You can also explore the potential benefits of stepping outside your comfort zone and weigh them against the security of staying within it. Acknowledge your fear, but don\'t let it paralyze you; instead, use it as a guide to prepare yourself better. Remember that growth often happens outside of our comfort zones, and it\'s okay to feel a bit uneasy during the process. Also, try to find someone who you can trust and share what you are feeling with.",\n      "timestamp": "2024-01-01"\n    }\n  ],\n  "quotes": [\n    {\n      "author": "Eleanor Roosevelt",\n      "quote": "You gain strength, courage, and confidence by every experience in which you really stop to look fear in the face. You are able to say to yourself, \'I lived through this horror. I can take the next thing that comes along.\'"\n    },\n    {\n      "author": "Neale Donald Walsch",\n      "quote": "Life begins at the end of your comfort zone."\n    }\n  ],\n  "title": "Analyzing User\'s Conflict Between Comfort Zone and New Experiences"\n}'),
      ]),
    ]);
    final message = query;
    final content = Content.text(message);

    final response = await chat.sendMessage(content);
    final data = jsonDecode(response.text!) as Map<String, dynamic>;
    return JournalResponseModel.fromJson(data);
  }
  static Future<JournalResponseModel> getImprovedResponse(String query) async {
    final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey.value,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          requiredProperties: ["title", "queries", "emotions", "quotes"],
          properties: {
            "title": Schema(SchemaType.string),
            "queries": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["query", "solution", "timestamp"],
                properties: {
                  "query": Schema(SchemaType.string),
                  "solution": Schema(SchemaType.string),
                  "timestamp": Schema(SchemaType.string),
                },
              ),
            ),
            "emotions": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["emotion", "percentage", "colorHex"],
                properties: {
                  "emotion": Schema(SchemaType.string),
                  "percentage": Schema(SchemaType.integer),
                  "colorHex": Schema(SchemaType.string),
                },
              ),
            ),
            "quotes": Schema(
              SchemaType.array,
              items: Schema(
                SchemaType.object,
                requiredProperties: ["quote", "author"],
                properties: {
                  "quote": Schema(SchemaType.string),
                  "author": Schema(SchemaType.string),
                },
              ),
            ),
          },
        ),
      ),
    );

    final chat = model.startChat(history: []);

    final content = Content.text(
        "Improve the response while keeping the original query unchanged. "
            "Return the structured JSON but ensure that the 'query' field remains: \"$query\""
    );

    final response = await chat.sendMessage(content);
    final data = jsonDecode(response.text!) as Map<String, dynamic>;
    return JournalResponseModel.fromJson(data);
  }

}
