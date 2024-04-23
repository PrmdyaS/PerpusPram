class Endpoint {
  static const String baseUrlApi = "https://api-perpus-pram.vercel.app/";
  // static const String baseUrlApi = "http://localhost:3000/";

  static const String login = "${baseUrlApi}users/login";
  static const String register = "${baseUrlApi}users";
  static const String listUsers = "${baseUrlApi}users/list-users";
  static const String updateRoleUsers = "${baseUrlApi}users/roles";
  static const String user = "${baseUrlApi}users";
  static const String roles = "${baseUrlApi}roles";
  static const String checkUsername = "${baseUrlApi}users/username";
  static const String allBooks = "${baseUrlApi}books";
  static const String ratingTertinggi = "${baseUrlApi}books/rating-tertinggi";
  static const String terbaru = "${baseUrlApi}books/terbaru";
  static const String favoriteSaya = "${baseUrlApi}favorites";
  static const String subCategories = "${baseUrlApi}sub-categories";
  static const String subCategoriesList = "${baseUrlApi}sub-categories/list";
  static const String borrowBooks = "${baseUrlApi}borrow-books";
  static const String laporanPeminjaman = "${baseUrlApi}borrow-books/laporan";
  static const String laporanDenda = "${baseUrlApi}borrow-books/laporan-denda";
  static const String searchBooks = "${baseUrlApi}books/search";
  static const String searchDataBooks = "${baseUrlApi}books/search-data";
  static const String reviews = "${baseUrlApi}reviews/";
  static const String reviewsUsersBooks = "${baseUrlApi}reviews/users/books";
  static const String menuBooks = "${baseUrlApi}books/menu-book";
  static const String genres = "${baseUrlApi}genres/";
  static const String denda = "${baseUrlApi}denda/";
}
