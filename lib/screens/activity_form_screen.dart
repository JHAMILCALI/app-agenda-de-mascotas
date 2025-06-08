import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:app_agenda_de_mascotas/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({super.key});

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
      Navigator.pop(
        context,
        PetActivity(
          type: _selectedType,
          date: _selectedDate,
          comment: _commentController.text,
        ),
      );
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
              // Tipo de actividad
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

              // Fecha
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

              // Comentario
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Comentario (opcional)',
                  prefixIcon: Icon(Icons.comment),
                ),
                maxLength: 100,
              ),
              const SizedBox(height: 30),

              // Botón para agregar
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
