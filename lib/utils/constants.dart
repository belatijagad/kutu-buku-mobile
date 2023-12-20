class Constants {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static const String register = '$baseUrl/register/';
  static const String login = '$baseUrl/login/';
  static const String logout = '$baseUrl/logout/';

  static const String changePassword = '$baseUrl/change_password/';

  static const String addBook = '$baseUrl/add_book/';
  static const String books = '$baseUrl/books/';
  static const String pendingBooks = '$baseUrl/fetch_approval/';
  static const String createBooks = '$baseUrl/books/create/';
  static const String searchBooks = '$baseUrl/search/';
  static const String searchBookmark = '$baseUrl/search_bookmark/';

  static const String getGenres = '$baseUrl/get_genres/';
  static const String getUser = '$baseUrl/get_user/';

  static String getBook(int id) {
    return '$baseUrl/books/$id/';
  }

  static String bookmarkBook(int id) {
    return '$baseUrl/bookmark/$id/';
  }

  static String checkBookmark(int id) {
    return '$baseUrl/is_bookmarked/$id/';
  }

  static String submitReview(int id) {
    return '$baseUrl/submit_review/$id/';
  }

  static String fetchReview(int id) {
    return '$baseUrl/fetch_reviews/$id/';
  }

  static String deleteReview(int id) {
    return '$baseUrl/delete_review/$id/';
  }

  static String getReview(int id) {
    return '$baseUrl/get_review/$id';
  }

  static String updateProgress(int bookId, int chaptNumber) {
    return '$baseUrl/update_progress/$bookId/$chaptNumber';
  }

  static String getProgress(int id) {
    return '$baseUrl/get_progress/$id';
  }

  static String approveBook(int id) {
    return '$baseUrl/books/$id/approve/';
  }

  static String deleteBook(int id) {
    return '$baseUrl/books/$id/delete/';
  }

  static String upvoteReview(int id) {
    return '$baseUrl/reviews/$id/upvote';
  }

  static String downvoteReview(int id) {
    return '$baseUrl/reviews/$id/downvote';
  }

  static String getVoteStatus(int id) {
    return '$baseUrl/get_vote_status/$id/';
  }
}
