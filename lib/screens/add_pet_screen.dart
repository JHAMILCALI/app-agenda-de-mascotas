// lib/screens/add_pet_screen.dart
import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';

class AddPetScreen extends StatefulWidget {
  final Function(Pet) onPetAdded;

  const AddPetScreen({super.key, required this.onPetAdded});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String _selectedType = 'Perro';
  String _selectedColor = '#6DC0D5';

  final List<String> _petTypes = [
    'Perro',
    'Gato',
    'Pájaro',
    'Conejo',
    'Hamster',
    'Otro',
  ];

  final List<Map<String, String>> _colors = [
    {'name': 'Azul', 'value': '#6DC0D5'},
    {'name': 'Naranja', 'value': '#FFA857'},
    {'name': 'Verde', 'value': '#4CAF50'},
    {'name': 'Morado', 'value': '#9C27B0'},
    {'name': 'Rosa', 'value': '#E91E63'},
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newPet = Pet(
        id: DateTime.now().toIso8601String(),
        name: _nameController.text,
        type: _selectedType,
        color: _selectedColor,
      );

      widget.onPetAdded(newPet);
      Navigator.pop(context, newPet); // <- DEVUELVE la mascota
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Mascota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la mascota',
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de mascota',
                  prefixIcon: Icon(Icons.category),
                ),
                items:
                    _petTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged:
                    (value) => setState(() {
                      _selectedType = value!;
                    }),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedColor,
                decoration: const InputDecoration(
                  labelText: 'Color representativo',
                  prefixIcon: Icon(Icons.color_lens),
                ),
                items:
                    _colors.map((color) {
                      return DropdownMenuItem(
                        value: color['value'],
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(
                                  int.parse(
                                    color!['value']!.replaceFirst('#', '0xFF'),
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(color['name']!),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged:
                    (value) => setState(() {
                      _selectedColor = value!;
                    }),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Guardar Mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
