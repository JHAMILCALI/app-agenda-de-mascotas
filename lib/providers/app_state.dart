import 'package:flutter/material.dart';
import 'package:app_agenda_de_mascotas/models/pet.dart';
import 'package:app_agenda_de_mascotas/models/pet_activity.dart';
import 'package:uuid/uuid.dart';

class AppState extends ChangeNotifier {
  final List<Pet> _pets = [];

  List<Pet> get pets => List.unmodifiable(_pets);

  final Uuid _uuid = const Uuid();

  // Obtener mascota por id
  Pet getPetById(String id) {
    return _pets.firstWhere((pet) => pet.id == id);
  }

  // Agrega una nueva mascota
  void addPet(String name, String type, String color) {
    final newPet = Pet(id: _uuid.v4(), name: name, type: type, color: color);
    _pets.add(newPet);
    notifyListeners();
  }

  // Agrega una actividad a una mascota específica por id
  void addActivityToPet(
    String petId,
    String activityType,
    String comment,
    DateTime date,
  ) {
    final petIndex = _pets.indexWhere((pet) => pet.id == petId);
    if (petIndex == -1) return;

    final newActivity = PetActivity(
      id: _uuid.v4(),
      petId: petId,
      type: activityType,
      comment: comment,
      date: date,
      completed: false,
    );

    _pets[petIndex].activities.add(newActivity);
    notifyListeners();
  }

  // Cambia el estado de completado de una actividad
  void toggleActivityCompletion(String petId, String activityId) {
    final petIndex = _pets.indexWhere((pet) => pet.id == petId);
    if (petIndex == -1) return;

    final activities = _pets[petIndex].activities;
    final activityIndex = activities.indexWhere((a) => a.id == activityId);
    if (activityIndex == -1) return;

    activities[activityIndex].completed = !activities[activityIndex].completed;
    notifyListeners();
  }
}
