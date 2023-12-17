class Book {
  int id, price;
  String name, description;

  Book({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
    );
  }
}
