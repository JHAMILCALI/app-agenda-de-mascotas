import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';

class ActivityCard extends StatelessWidget {
  final PetActivity activity;
  final Function(String) onToggleCompletion;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activity.type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    activity.completed
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: activity.completed ? Colors.green : Colors.grey,
                  ),
                  onPressed: () => onToggleCompletion(activity.id),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  _formatDate(activity.date),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            if (activity.comment.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.comment, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      activity.comment,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final difference = date.difference(today).inDays;

    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Mañana';
    if (difference == -1) return 'Ayer';
    return DateFormat('EEE, dd/MM').format(date);
  }
}
