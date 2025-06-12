// lib/models/pet_activity.dart
import 'package:flutter/material.dart';

class PetActivity {
  final String id;
  final String petId;
  final String type;
  final String comment;
  final DateTime date;
  bool completed;

  PetActivity({
    required this.id,
    required this.petId,
    required this.type,
    required this.comment,
    required this.date,
    this.completed = false,
  });

  factory PetActivity.fromJson(Map<String, dynamic> json) => PetActivity(
    id: json['id'],
    petId: json['petId'],
    type: json['type'],
    comment: json['comment'],
    date: DateTime.parse(json['date']),
    completed: json['completed'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'petId': petId,
    'type': type,
    'comment': comment,
    'date': date.toIso8601String(),
    'completed': completed,
  };

  String formattedDate(BuildContext context) {
    final now = DateTime.now();
    final diff =
        DateTime(
          date.year,
          date.month,
          date.day,
        ).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff == 0) return 'Hoy';
    if (diff == 1) return 'Mañana';
    if (diff == -1) return 'Ayer';
    return '${date.day}/${date.month}/${date.year}';
  }
}
