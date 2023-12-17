class Constants {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static const String register = '$baseUrl/register/';
  static const String login = '$baseUrl/login/';

  static const String books = '$baseUrl/books/';
  static const String createBooks = '$baseUrl/books/create/';

  static String getBook(int id) {
    return '$baseUrl/books/$id/';
  }

  static String updateBook(int id) {
    return '$baseUrl/books/$id/update/';
  }

  static String deleteBook(int id) {
    return '$baseUrl/books/$id/delete/';
  }
}
