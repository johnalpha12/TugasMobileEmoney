class SavingGoal {
  String title;
  int amount;
  double progress;
  String? description;
  DateTime? targetDate;

  SavingGoal({
    required this.title,
    required this.amount,
    required this.progress,
    this.description,
    this.targetDate,
  });
}
