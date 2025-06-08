import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final PetActivity activity;

  const ActivityCard({super.key, required this.activity});

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
                // Icono
                _getActivityIcon(context, activity.type),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    activity.type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yy').format(activity.date),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            if (activity.comment.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(activity.comment, style: const TextStyle(fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _getActivityIcon(BuildContext context, String type) {
    IconData icon;
    Color color = Theme.of(context).colorScheme.primary;

    switch (type) {
      case 'Alimentación':
        icon = Icons.restaurant;
        break;
      case 'Baño':
        icon = Icons.shower;
        break;
      case 'Vacunas':
        icon = Icons.medical_services;
        break;
      case 'Paseo':
        icon = Icons.directions_walk;
        break;
      case 'Veterinario':
        icon = Icons.local_hospital;
        break;
      case 'Medicación':
        icon = Icons.medication;
        break;
      default:
        icon = Icons.pets;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
