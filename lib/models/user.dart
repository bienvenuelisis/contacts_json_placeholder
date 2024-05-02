class User {
  final int id;

  final String name;

  final String phone;

  final String email;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });
}

User fromJsonToUser(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
  );
}
