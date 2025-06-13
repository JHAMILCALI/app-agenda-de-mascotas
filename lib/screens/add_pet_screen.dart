import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  Color selectedColor = const Color(0xFF6DC0D5);

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        type: _typeController.text.trim(),
        color:
            '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
      );
      Navigator.pop(context, pet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Mascota')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Ingrese un nombre'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipo'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Ingrese un tipo'
                            : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Color: '),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _pickColor,
                    child: CircleAvatar(
                      backgroundColor: selectedColor,
                      radius: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Agregar Mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickColor() async {
    // Simple picker usando showDialog
    final color = await showDialog<Color>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Seleccione un color'),
            content: Wrap(
              spacing: 10,
              children:
                  [
                    Colors.orange,
                    Colors.blue,
                    Colors.purple,
                    Colors.green,
                    Colors.red,
                    Colors.teal,
                  ].map((c) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pop(c),
                      child: CircleAvatar(backgroundColor: c, radius: 16),
                    );
                  }).toList(),
            ),
          ),
    );

    if (color != null) {
      setState(() {
        selectedColor = color;
      });
    }
  }
}
