
class Constants {
  static const String baseUrl = 'http://aldenluth.fi/api';

  static const String register = '$baseUrl/register/';
  static const String login = '$baseUrl/login/';
  static const String logout = '$baseUrl/logout/';

  static const String changePassword = '$baseUrl/change_password/';

  static const String books = '$baseUrl/books/';
  static const String createBooks = '$baseUrl/books/create/';
  static const String searchBooks = '$baseUrl/search/';
  static const String getGenres = '$baseUrl/get_genres/';
  static const String getUser = '$baseUrl/get_user/';

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
