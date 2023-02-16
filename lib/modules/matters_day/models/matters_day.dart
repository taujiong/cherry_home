class MattersDay extends MattersDayCreateOrUpdateDto {
  final int id;

  const MattersDay({
    required this.id,
    required super.description,
    required super.targetDate,
  });

  bool get isExpired => DateTime.now().isAfter(targetDate);

  int get leftDaysFromNow => targetDate.difference(DateTime.now()).inDays;

  factory MattersDay.fromMap(Map<String, dynamic> map) => MattersDay(
        id: map['id'],
        description: map['description'],
        targetDate: DateTime.parse(map['targetDate']),
      );
}

class MattersDayCreateOrUpdateDto {
  final String description;
  final DateTime targetDate;

  const MattersDayCreateOrUpdateDto({
    required this.description,
    required this.targetDate,
  });

  Map<String, dynamic> toMap() => {
        'description': description,
        'targetDate': targetDate.toString(),
      };
}
