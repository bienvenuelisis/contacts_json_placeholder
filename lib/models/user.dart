class User {
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  final String email;
  final int id;
  final String name;
  final String phone;
}

User fromJsonToUser(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
  );
}
