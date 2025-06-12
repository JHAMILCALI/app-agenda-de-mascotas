import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:flutter/material.dart';

class UpcomingActivityCard extends StatelessWidget {
  final PetActivity activity;
  final Pet pet;
  final Function(String) onToggleCompletion;

  const UpcomingActivityCard({
    super.key,
    required this.activity,
    required this.pet,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(
                        int.parse(pet.color.replaceFirst('#', '0xFF')),
                      ),
                      child: Text(
                        pet.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      radius: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      pet.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  activity.formattedDate(context), // ← Usamos el nuevo método
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.type,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (activity.comment.isNotEmpty)
                        Text(
                          activity.comment,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    activity.completed
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color:
                        activity.completed
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => onToggleCompletion(activity.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
