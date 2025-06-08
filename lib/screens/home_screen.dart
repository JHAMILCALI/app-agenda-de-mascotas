import 'package:flutter/material.dart';
import 'activity_form_screen.dart';
import '../widgets/activity_list.dart';
import '../widgets/empty_state.dart';
import '../models/pet_activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PetActivity> _activities = [];

  void _addActivity(PetActivity newActivity) {
    setState(() {
      _activities.add(newActivity);
      _activities.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _navigateToForm(BuildContext context) async {
    final result = await Navigator.push<PetActivity>(
      context,
      MaterialPageRoute(builder: (context) => const ActivityFormScreen()),
    );

    if (result != null) {
      _addActivity(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Agenda de Mascota'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToForm(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actividades Registradas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _activities.isEmpty
                      ? const EmptyState(
                        icon: Icons.event_note,
                        message: 'No hay actividades registradas',
                      )
                      : ActivityList(activities: _activities),
            ),
          ],
        ),
      ),
    );
  }
}
