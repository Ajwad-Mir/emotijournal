import 'package:emotijournal/app/apis/openai_apis.dart';
import 'package:emotijournal/app/database/journal_database.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class JournalManagementController extends GetxController {
  final emotionsTextController = TextEditingController();
  final isListening = false.obs;
  final generatedJournal = JournalModel.empty().obs;

  final pageController = PageController();
  final textController = TextEditingController();

  final selectedTabBarIndex = 0.obs;

  final SpeechToText speech = SpeechToText();

  void _startListening() async {
    await speech.initialize();
    isListening.value = true;
    await speech.listen(
      listenFor: 2.minutes,
      listenOptions: SpeechListenOptions(
        partialResults: false,
        cancelOnError: false,
        listenMode: ListenMode.dictation,
      ),
      onResult: (val) {
        emotionsTextController.text = val.recognizedWords;
      },
    );
  }

  void _stopListening() async {
    await speech.stop();
    isListening.value = false;
  }

  Future<void> createNewJournal() async {
    final journal =
        await JournalAI.getFirstResponse(emotionsTextController.text);
    generatedJournal.value = await JournalDatabase.createNewJournalEntry(
      JournalModel.fromJournalResponseModel(
        journal,
      ),
    );
    await Get.find<HomeController>().getAllJournalEntries();
  }

  Future<void> improveJournal() async {
    final originalJournal = generatedJournal.value;
    final journal = await JournalAI.getImprovedResponse(textController.text);
    generatedJournal.value = await JournalDatabase.updateJournalEntry(
        JournalModel.mergeWithResponseModel(originalJournal, journal));
    await Get.find<HomeController>().getAllJournalEntries();
  }

  void handleUserInput() {
    if (isListening.isTrue) {
      _stopListening();
      update();
      return;
    } else {
      _startListening();
      update();
      return;
    }
  }
}
