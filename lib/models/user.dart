import 'package:kutubuku/models/book.dart';

class User {
  final int id;
  final String username, password;
  int money, experience, level;
  List<Book> favorites;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.money,
    required this.experience,
    required this.level,
    required this.favorites,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var bookmarks = <Book>[];
    if (json['favorite_Books'] != null) {
      bookmarks = (json['favorite_Books'] as List)
          .map((item) => Book.fromJson(item))
          .toList();
    }

    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      money: json['money'],
      experience: json['experience'],
      level: json['level'],
      favorites: bookmarks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'money': money,
      'experience': experience,
      'level': level,
      'favorites': favorites,
    };
  }
}
