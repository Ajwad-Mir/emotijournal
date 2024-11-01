import 'package:emotijournal/app/models/option_model.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final ScrollController scrollController;
  final isCollapsed = false.obs;
  final selectedDate = DateTime.now().obs;
  final optionsList = <OptionModel>[
    OptionModel(text: 'Theme', icon: Assets.svgThemeSelection),
    OptionModel(text: 'Subscriptions', icon: Assets.svgSubscriptions),
    OptionModel(text: 'Logout', icon: Assets.svgLogout),
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > 125.h && isCollapsed.isFalse) {
      isCollapsed.value = true;
    } else if (scrollController.offset <= 125.h && isCollapsed.isTrue) {
      isCollapsed.value = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}