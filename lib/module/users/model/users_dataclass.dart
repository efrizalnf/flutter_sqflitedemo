class Users {
  final int? id;
  final String name;
  final int age;

  const Users({
    this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
