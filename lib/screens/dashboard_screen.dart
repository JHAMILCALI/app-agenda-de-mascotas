import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/screens/pets_screen.dart';
import 'package:app_agenda_de_mascotas/widgets/upcoming_activity_card.dart';
import 'package:app_agenda_de_mascotas/widgets/progress_chip.dart';
import 'package:app_agenda_de_mascotas/widgets/empty_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Pet> pets = [];
  List<PetActivity> activities = [];
  int completedCount = 0;

  @override
  void initState() {
    super.initState();
    // Datos de ejemplo
    pets = [
      Pet(id: '1', name: 'Firulais', type: 'Perro', color: '#FFA857'),
      Pet(id: '2', name: 'Michi', type: 'Gato', color: '#6DC0D5'),
    ];

    activities = [
      PetActivity(
        id: '1',
        petId: '1',
        type: 'Vacunas',
        date: DateTime.now().add(const Duration(days: 2)),
        comment: 'Vacuna antirrábica',
      ),
      PetActivity(
        id: '2',
        petId: '2',
        type: 'Baño',
        date: DateTime.now().add(const Duration(days: 1)),
        comment: 'Baño con shampoo especial',
      ),
      PetActivity(
        id: '3',
        petId: '1',
        type: 'Paseo',
        date: DateTime.now(),
        comment: 'Paseo por el parque',
      ),
    ];

    completedCount = 1;
  }

  void _toggleActivityCompletion(String id) {
    setState(() {
      final activity = activities.firstWhere((a) => a.id == id);
      activity.completed = !activity.completed;
      completedCount = activities.where((a) => a.completed).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ordenar actividades por fecha (más próximas primero)
    final upcomingActivities =
        activities.where((a) => !a.completed).toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    final progress =
        activities.isNotEmpty ? completedCount / activities.length : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Mascotas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pets),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PetsScreen()),
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progreso general
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progreso General',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      color: Theme.of(context).colorScheme.primary,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressChip(
                          value: activities.length,
                          label: 'Total',
                          color: Colors.blueGrey,
                        ),
                        ProgressChip(
                          value: completedCount,
                          label: 'Completadas',
                          color: Colors.green,
                        ),
                        ProgressChip(
                          value: upcomingActivities.length,
                          label: 'Pendientes',
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Próximas actividades
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Próximas Actividades',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('Ver todas')),
              ],
            ),
            const SizedBox(height: 10),

            if (upcomingActivities.isEmpty)
              const EmptyState(
                icon: Icons.event_available,
                message: 'No hay actividades pendientes',
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: upcomingActivities.length,
                  itemBuilder: (context, index) {
                    final activity = upcomingActivities[index];
                    final pet = pets.firstWhere((p) => p.id == activity.petId);
                    return UpcomingActivityCard(
                      activity: activity,
                      pet: pet,
                      onToggleCompletion: _toggleActivityCompletion,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
