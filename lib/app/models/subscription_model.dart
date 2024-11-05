class SubscriptionModel {
  final String title;
  final String description;
  final List<String> benefits;
  final double monthlyPrice;
  final bool isCurrentPlan;

  SubscriptionModel({
    required this.title,
    required this.description,
    required this.benefits,
    required this.monthlyPrice,
    required this.isCurrentPlan,
  });
}
