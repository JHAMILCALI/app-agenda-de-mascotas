import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/providers/app_state.dart';
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
  void _toggleActivityCompletion(String petId, String activityId) {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.toggleActivityCompletion(petId, activityId);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final pets = appState.pets;

    // 🔧 Recolectar todas las actividades desde las mascotas
    final activities = pets.expand((pet) => pet.activities).toList();

    // Ordenar las actividades no completadas por fecha (de hoy en adelante)
    final now = DateTime.now();
    final upcomingActivities =
        activities
            .where(
              (a) =>
                  !a.completed &&
                  !a.date.isBefore(DateTime(now.year, now.month, now.day)),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    final completedCount = activities.where((a) => a.completed).length;
    final progress =
        activities.isNotEmpty ? completedCount / activities.length : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Mascotas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pets),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PetsScreen()),
              );
            },
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

            // Título de sección
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

            // Lista o estado vacío
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
                    final pet = pets.firstWhere(
                      (p) => p.id == activity.petId,
                      orElse:
                          () => Pet(
                            id: '0',
                            name: 'Desconocido',
                            type: '',
                            color: '#CCCCCC',
                          ),
                    );
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PetsScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
