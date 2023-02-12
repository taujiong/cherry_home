class MattersDay {
  final int id;
  final String description;
  final DateTime targetDate;

  const MattersDay(
    this.id,
    this.description,
    this.targetDate,
  );

  bool get isExpired => DateTime.now().isAfter(targetDate);

  int get leftDaysFromNow => targetDate.difference(DateTime.now()).inDays;

  Map<String, dynamic> toMap() => {
        'description': description,
        'targetDate': targetDate.toString(),
      };

  factory MattersDay.fromMap(Map<String, dynamic> map) => MattersDay(
        map['id'],
        map['description'],
        DateTime.parse(map['targetDate']),
      );

  factory MattersDay.fromDto(description, targetDate) =>
      MattersDay(0, description, targetDate);
}
