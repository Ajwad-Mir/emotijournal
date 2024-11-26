import 'package:emotijournal/app/apis/openai_apis.dart';
import 'package:emotijournal/app/database/journal_database.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JournalManagementController extends GetxController {
  final emotionsTextController = TextEditingController();
  final currentTextAlign = TextAlign.center.obs;
  final isListening = false.obs;
  final generatedJournal = JournalModel.empty().obs;

  final pageController = PageController();
  final textController = TextEditingController();

  Future<void> createNewJournal() async {
    final journal = await JournalAI.getFirstResponse(emotionsTextController.text);
    generatedJournal.value = await JournalDatabase.createNewJournalEntry(
      JournalModel.fromJournalResponseModel(journal),
    );
    Get.find<HomeController>().journalList.clear();
    await Get.find<HomeController>().getAllJournalEntries();
  }

  Future<void> improveJournal() async {
    final id = generatedJournal.value.id;
    final journal = await JournalAI.getImprovedResponse(textController.text);
    generatedJournal.value = JournalModel.fromJournalResponseModel(journal).copyWith(
      id: id
    );
    generatedJournal.value = await JournalDatabase.updateJournalEntry(generatedJournal.value);
    Get.find<HomeController>().journalList.clear();
    await Get.find<HomeController>().getAllJournalEntries();
  }
}
