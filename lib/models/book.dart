import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  // factory Book.fromJson(Map<String, dynamic> json) => Book(
  //       // model: json["model"],
  //       // pk: json["pk"],
  //       // fields: Fields.fromJson(json["fields"]),
  //     );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
  factory Book.fromJson(Map<String, dynamic> json) {
    try {
      return Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );
    } catch (e) {
      // print('Error parsing Book JSON: $e');
      print('Book JSON: $json');
      rethrow; // This will allow the error to be propagated up the stack
    }
  }
}

class Fields {
  String? author;
  dynamic user;
  String title;
  int chapters;
  String imgSrc;
  String synopsis;
  int reviewers;
  double score;
  double averageScore;
  DateTime publishedAt;
  List<String> genre;

  Fields({
    this.author,
    this.user,
    required this.title,
    required this.chapters,
    required this.imgSrc,
    required this.synopsis,
    required this.reviewers,
    required this.score,
    required this.averageScore,
    required this.publishedAt,
    required this.genre,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["author"] ?? "",
        user: json["user"] ?? "",
        title: json["title"],
        chapters: json["chapters"],
        imgSrc: json["img_src"],
        synopsis: json["synopsis"],
        reviewers: json["reviewers"],
        score: json["score"],
        averageScore: json["average_score"],
        publishedAt: DateTime.parse(json["published_at"]),
        genre: List<String>.from(json["genre"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "user": user,
        "title": title,
        "chapters": chapters,
        "img_src": imgSrc,
        "synopsis": synopsis,
        "reviewers": reviewers,
        "score": score,
        "average_score": averageScore,
        "published_at":
            "${publishedAt.year.toString().padLeft(4, '0')}-${publishedAt.month.toString().padLeft(2, '0')}-${publishedAt.day.toString().padLeft(2, '0')}",
        "genre": List<dynamic>.from(genre.map((x) => x)),
      };
}
