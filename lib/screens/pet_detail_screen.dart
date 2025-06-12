import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/screens/activity_form_screen.dart';
import 'package:app_agenda_de_mascotas/widgets/activity_card.dart';
import 'package:app_agenda_de_mascotas/widgets/empty_state.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  List<PetActivity> activities = [];

  @override
  void initState() {
    super.initState();
    // Datos de ejemplo específicos para esta mascota
    activities = [
      PetActivity(
        id: '1',
        petId: widget.pet.id,
        type: 'Vacunas',
        date: DateTime.now().add(const Duration(days: 2)),
        comment: 'Vacuna antirrábica',
        completed: false,
      ),
      PetActivity(
        id: '2',
        petId: widget.pet.id,
        type: 'Baño',
        date: DateTime.now().add(const Duration(days: 5)),
        comment: 'Baño con shampoo especial',
        completed: false,
      ),
      PetActivity(
        id: '3',
        petId: widget.pet.id,
        type: 'Paseo',
        date: DateTime.now().subtract(const Duration(days: 1)),
        comment: 'Paseo por el parque',
        completed: true,
      ),
    ];
  }

  void _addActivity(PetActivity newActivity) {
    setState(() {
      activities.add(newActivity);
    });
  }

  void _toggleActivityCompletion(String id) {
    setState(() {
      final activity = activities.firstWhere((a) => a.id == id);
      activity.completed = !activity.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Separar actividades completadas y pendientes
    final upcomingActivities = activities.where((a) => !a.completed).toList();
    final completedActivities = activities.where((a) => a.completed).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.pet.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información de la mascota
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(
                        int.parse(widget.pet.color.replaceFirst('#', '0xFF')),
                      ),
                      child: Text(
                        widget.pet.name[0],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pet.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.pet.type,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Actividades pendientes
            const Text(
              'Actividades Pendientes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (upcomingActivities.isEmpty)
              const EmptyState(
                icon: Icons.event_available,
                message: 'No hay actividades pendientes',
                size: 80,
              )
            else
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: upcomingActivities.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(
                      activity: upcomingActivities[index],
                      onToggleCompletion: _toggleActivityCompletion,
                    );
                  },
                ),
              ),

            // Actividades completadas
            const SizedBox(height: 20),
            const Text(
              'Actividades Completadas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (completedActivities.isEmpty)
              const EmptyState(
                icon: Icons.check_circle,
                message: 'No hay actividades completadas',
                size: 80,
              )
            else
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: completedActivities.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(
                      activity: completedActivities[index],
                      onToggleCompletion: _toggleActivityCompletion,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ActivityFormScreen(
                      petId: widget.pet.id,
                      onActivityAdded: _addActivity,
                    ),
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
