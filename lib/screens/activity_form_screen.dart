import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/utils/date_formatter.dart';

class ActivityFormScreen extends StatefulWidget {
  final String petId;
  final Function(PetActivity) onActivityAdded;

  const ActivityFormScreen({
    super.key,
    required this.petId,
    required this.onActivityAdded,
  });

  @override
  State<ActivityFormScreen> createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Alimentación';
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _commentController = TextEditingController();

  final List<String> _activityTypes = [
    'Alimentación',
    'Baño',
    'Vacunas',
    'Paseo',
    'Veterinario',
    'Medicación',
    'Corte de uñas',
    'Cepillado',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newActivity = PetActivity(
        id: DateTime.now().toString(),
        petId: widget.petId,
        type: _selectedType,
        date: _selectedDate,
        comment: _commentController.text,
        completed: false, // or true, depending on your logic
      );

      widget.onActivityAdded(newActivity);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Actividad')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de actividad',
                  prefixIcon: Icon(Icons.pets),
                ),
                items:
                    _activityTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: DateFormatter.formatDate(_selectedDate),
                ),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Comentario (opcional)',
                  prefixIcon: Icon(Icons.comment),
                ),
                maxLength: 100,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Actividad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
