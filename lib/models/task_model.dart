

class Task {
  final String id;
  final String name;
  final String description;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    this.isCompleted = false, // Par défaut, une tâche n'est pas complétée
  });
}