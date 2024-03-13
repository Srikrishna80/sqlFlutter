class Dog {
  final int? id; // Make id nullable
  final String name;
  final int age;

  // Update constructor to accept nullable id
  Dog({
    this.id,
    required this.name,
    required this.age,
  });

  // Update toMap method to handle null id
  Map<String, Object?> toMap() {
    return {
      'id': id, // Allow id to be null
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
