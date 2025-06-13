class PetActivity {
  final String id;
  final String petId; // <--- Aquí el id de la mascota
  final String type;
  final String comment;
  final DateTime date;
  bool completed;

  PetActivity({
    required this.id,
    required this.petId, // Lo agregamos aquí en el constructor
    required this.type,
    required this.comment,
    required this.date,
    this.completed = false,
  });
}
