import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/providers/app_state.dart';
import 'package:app_agenda_de_mascotas/screens/add_pet_screen.dart';
import 'package:app_agenda_de_mascotas/screens/pet_detail_screen.dart';
import 'package:app_agenda_de_mascotas/widgets/pet_card.dart';
import 'package:app_agenda_de_mascotas/widgets/empty_state.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<AppState>(context);
    final pets = petProvider.pets;

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
                    final pet = pets[index];
                    return PetCard(
                      pet: pet,
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetDetailScreen(pet: pet),
                            ),
                          ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ← Mostrar AddPetScreen y esperar resultado
          final newPet = await Navigator.push<Pet>(
            context,
            MaterialPageRoute(builder: (context) => const AddPetScreen()),
          );

          if (newPet != null) {
            Provider.of<AppState>(
              context,
              listen: false,
            ).addPet(newPet.name, newPet.type, newPet.color);
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
