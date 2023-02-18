import 'package:cloud_firestore/cloud_firestore.dart';

class MattersDay {
  static final collectionRef =
      FirebaseFirestore.instance.collection('matters_day').withConverter(
            fromFirestore: (snapshot, options) =>
                MattersDay.fromJson(snapshot.data()!),
            toFirestore: (day, options) => day.toJson(),
          );

  String description;
  DateTime targetDate;

  MattersDay({
    required this.description,
    required this.targetDate,
  });

  bool get isExpired => DateTime.now().isAfter(targetDate);

  int get leftDaysFromNow => targetDate.difference(DateTime.now()).inDays;

  factory MattersDay.fromJson(Map<String, dynamic> map) => MattersDay(
        description: map['description'],
        targetDate: (map['targetDate'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'targetDate': targetDate,
      };
}
