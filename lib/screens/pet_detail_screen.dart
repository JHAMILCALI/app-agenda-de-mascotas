import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/providers/app_state.dart';
import 'package:app_agenda_de_mascotas/widgets/activity_card.dart';
import 'package:uuid/uuid.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  final _typeController = TextEditingController();
  final _commentController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _addActivity() {
    if (_typeController.text.isEmpty) return;

    Provider.of<AppState>(context, listen: false).addActivityToPet(
      widget.pet.id,
      _typeController.text.trim(),
      _commentController.text.trim(),
      selectedDate,
    );

    _typeController.clear();
    _commentController.clear();
    selectedDate = DateTime.now();
    FocusScope.of(context).unfocus();
  }

  void _toggleCompletion(String activityId) {
    Provider.of<AppState>(
      context,
      listen: false,
    ).toggleActivityCompletion(widget.pet.id, activityId);
  }

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<AppState>(context).getPetById(widget.pet.id);

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(
                    int.parse(pet.color.replaceFirst('#', '0xFF')),
                  ),
                  child: Text(
                    pet.name[0],
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pet.type,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Agregar Actividad',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Tipo de actividad'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Comentario'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _addActivity,
                  child: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Actividades',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child:
                  pet.activities.isEmpty
                      ? const Center(child: Text('Sin actividades registradas'))
                      : ListView.builder(
                        itemCount: pet.activities.length,
                        itemBuilder: (context, index) {
                          final activity = pet.activities[index];
                          return ActivityCard(
                            activity: activity,
                            onToggleCompletion: _toggleCompletion,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
