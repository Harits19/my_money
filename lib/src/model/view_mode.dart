enum ViewMode {
  daily("DAILY"),
  weekly("WEEKLY"),
  monthly("MONTHLY"),
  threeMonths("3 MONTHS"),
  sixMonths("6 MONTHS"),
  yearly("YEARLY");

  const ViewMode(this.text);

  final String text;
}
