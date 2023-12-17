import 'dart:convert';

List<String> genreFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String genreToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
