import 'package:emotijournal/app/database/journal_database.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final ScrollController scrollController;
  final isCollapsed = false.obs;
  final isLoading = true.obs;
  final selectedDate = DateTime.now().obs;
  final journalList = <JournalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > 175.h && isCollapsed.isFalse) {
      isCollapsed.value = true;
    } else if (scrollController.offset <= 175.h && isCollapsed.isTrue) {
      isCollapsed.value = false;
    }
  }

  Future<void> getAllJournalEntries() async{
    journalList.clear();
    isLoading.value = true;
    journalList.addAll(await JournalDatabase.getAllJournalEntries());
    isLoading.value = false;
    update();
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
