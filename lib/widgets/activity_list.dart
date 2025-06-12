import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/widgets/activity_card.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatelessWidget {
  final List<PetActivity> activities;

  const ActivityList({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ActivityCard(
          activity: activities[index],
          onToggleCompletion: (String) {},
        );
      },
    );
  }
}
