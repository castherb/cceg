class Course {
  final int id;
  final String name;
  final String description;
  final bool isTaken;

  Course({required this.id, required this.name, required this.description, this.isTaken = false});

  factory Course.fromMap(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isTaken: json['isTaken'] == 1,
    );
  }
}
