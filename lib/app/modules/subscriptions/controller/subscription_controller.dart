import 'package:emotijournal/app/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionsController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;
  final offers = <SubscriptionModel>[
    SubscriptionModel(
      title: "Free Plan",
      description:
          "Feeling curious but not ready to commit? We’ve got your back with free daily chats and simple tools to explore your emotions.",
      benefits: [
        "3 AI chats per day",
        "Basic emotions list",
        "Text-only journal entries",
        "Simple daily prompts",
        "Basic mood insights",
      ],
      monthlyPrice: 0.00,
      isCurrentPlan: true,
    ),
    SubscriptionModel(
      title: "Premium Plan",
      description:
          "Ready to transform your emotional journey? Unlock unlimited AI chats, powerful mood insights, and versatile journaling tools your path to self-discovery!",
      benefits: [
        "Unlimited AI chats",
        "Extensive emotions list",
        "Text and Audio journal entries"
            "Extensive mood insights",
      ],
      monthlyPrice: 4.99,
      isCurrentPlan: false,
    )
  ];
}
