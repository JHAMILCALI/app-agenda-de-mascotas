import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/screens/add_pet_screen.dart';
import 'package:app_agenda_de_mascotas/screens/pet_detail_screen.dart';
import 'package:app_agenda_de_mascotas/widgets/pet_card.dart';
import 'package:app_agenda_de_mascotas/widgets/empty_state.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    // Datos de ejemplo
    pets = [
      Pet(id: '1', name: 'Firulais', type: 'Perro', color: '#FFA857'),
      Pet(id: '2', name: 'Michi', type: 'Gato', color: '#6DC0D5'),
      Pet(id: '3', name: 'Lola', type: 'Conejo', color: '#A78BFA'),
    ];
  }

  void _addPet(Pet newPet) {
    setState(() {
      pets.add(newPet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Mascotas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            pets.isEmpty
                ? const EmptyState(
                  icon: Icons.pets,
                  message: 'No hay mascotas registradas',
                )
                : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    return PetCard(
                      pet: pets[index],
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      PetDetailScreen(pet: pets[index]),
                            ),
                          ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPet = await Navigator.push<Pet>(
            context,
            MaterialPageRoute(
              builder:
                  (context) => AddPetScreen(
                    onPetAdded: (Pet) {},
                  ), // ya no pasas onPetAdded
            ),
          );

          if (newPet != null) {
            _addPet(newPet);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
