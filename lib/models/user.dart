import 'dart:convert';

class User {
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;

  User({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      picture: json['picture'],
    );
  }

  static List<User> fromJsonList(String responseBody) {
    final Map<String, dynamic> data = jsonDecode(responseBody);
    return (data['data'] as List).map((json) => User.fromJson(json)).toList();
  }
}
