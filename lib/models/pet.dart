import 'package:app_agenda_de_mascotas/models/pet_activity.dart';

class Pet {
  final String id;
  final String name;
  final String type;
  final String color;
  final List<PetActivity> activities;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
    List<PetActivity>? activities,
  }) : activities = activities ?? [];

  // Método para copiar con modificaciones (útil para actualizar)
  Pet copyWith({
    String? id,
    String? name,
    String? type,
    String? color,
    List<PetActivity>? activities,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      color: color ?? this.color,
      activities: activities ?? this.activities,
    );
  }
}
