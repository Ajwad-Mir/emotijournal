import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JournalManagementController  extends GetxController {
  final emotionsTextController = TextEditingController();
  final currentTextAlign = TextAlign.center.obs;
  final isListening = false.obs;


  final pageController = PageController();
  final textController = TextEditingController();

}