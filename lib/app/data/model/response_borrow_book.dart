class ResponseBorrowBook {
  ResponseBorrowBook({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseBorrowBook.fromJson(Map<String, dynamic> json) {
    return ResponseBorrowBook(
      status: json['status'],
      message: json['message'],
      data: List<BorrowBook>.from(json['data'].map((x) => BorrowBook.fromJson(x))),
    );
  }

  int? status;
  String? message;
  List<BorrowBook>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class BorrowBook {
  BorrowBook({
    this.id,
    this.usersId,
    this.booksId,
    this.borrowingDate,
    this.returnDate,
    this.status,
    this.denda,
    this.review,
    this.dendas,
    this.users,
    this.books,
  });

  BorrowBook.fromJson(dynamic json) {
    id = json['_id'];
    usersId = json['users_id'];
    booksId = json['books_id'];
    borrowingDate = json['borrowing_date'];
    returnDate = json['return_date'];
    status = json['status'];
    denda = json['denda'];
    review = json['review'];
    dendas = json['dendas'] != null ? Dendas.fromJson(json['dendas']) : null;
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    books = json['books'] != null ? Books.fromJson(json['books']) : null;
  }

  String? id;
  String? usersId;
  String? booksId;
  String? borrowingDate;
  String? returnDate;
  String? status;
  int? denda;
  int? review;
  Dendas? dendas;
  Users? users;
  Books? books;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['users_id'] = usersId;
    data['books_id'] = booksId;
    data['borrowing_date'] = borrowingDate;
    data['return_date'] = returnDate;
    data['status'] = status;
    data['denda'] = denda;
    data['review'] = review;
    data['dendas'] = dendas?.toJson();
    data['users'] = users?.toJson();
    data['books'] = books?.toJson();
    return data;
  }
}

class Users {
  Users({
    this.id,
    this.email,
    this.password,
    this.username,
    this.namaLengkap,
    this.alamat,
    this.noHp,
  });

  Users.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
  }

  String? id;
  String? email;
  String? password;
  String? username;
  String? namaLengkap;
  String? alamat;
  String? noHp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['username'] = username;
    map['nama_lengkap'] = namaLengkap;
    map['alamat'] = alamat;
    map['no_hp'] = noHp;
    return map;
  }
}

class Books {
  Books({
    this.id,
    this.judul,
    this.penulis,
    this.penerbit,
    this.tahunTerbit,
    this.deskripsiBuku,
    this.sampulBuku,
    this.rating,
  });

  Books.fromJson(dynamic json) {
    id = json['_id'];
    judul = json['judul'];
    penulis = json['penulis'];
    penerbit = json['penerbit'];
    tahunTerbit = json['tahun_terbit'];
    deskripsiBuku = json['deskripsi_buku'];
    sampulBuku = json['sampul_buku'];
    rating = json['rating'];
  }

  String? id;
  String? judul;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? deskripsiBuku;
  String? sampulBuku;
  String? rating;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['judul'] = judul;
    data['penulis'] = penulis;
    data['penerbit'] = penerbit;
    data['tahun_terbit'] = tahunTerbit;
    data['deskripsi_buku'] = deskripsiBuku;
    data['sampul_buku'] = sampulBuku;
    data['rating'] = rating;
    return data;
  }
}

class Dendas {
  Dendas({
    this.id,
    this.paymentMethod,
    this.userIdOfficer,
    this.paymentDate,
    this.buktiPembayaran,
    this.officer,
  });

  Dendas.fromJson(dynamic json) {
    id = json['_id'];
    paymentMethod = json['payment_method'];
    userIdOfficer = json['user_id_officer'];
    paymentDate = json['payment_date'];
    buktiPembayaran = json['bukti_pembayaran'];
    officer = json['officer'] != null ? Officer.fromJson(json['officer']) : null;
  }

  String? id;
  String? paymentMethod;
  String? userIdOfficer;
  String? paymentDate;
  String? buktiPembayaran;
  Officer? officer;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['judul'] = paymentMethod;
    data['user_id_officer'] = userIdOfficer;
    data['payment_date'] = paymentDate;
    data['bukti_pembayaran'] = buktiPembayaran;
    data['officer'] = officer?.toJson();
    return data;
  }
}

class Officer {
  Officer({
    this.id,
    this.username,
  });

  Officer.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
  }

  String? id;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    return map;
  }
}