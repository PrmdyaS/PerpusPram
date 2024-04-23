class ResponseBook {
  ResponseBook({
      this.status, 
      this.message, 
      this.data,
  });

  factory ResponseBook.fromJson(Map<String, dynamic> json) {
    return ResponseBook(
      status: json['status'],
      message: json['message'],
      data: List<DataBook>.from(json['data'].map((x) => DataBook.fromJson(x))),
    );
  }
  int? status;
  String? message;
  List<DataBook>? data;

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

class DataBook {
  DataBook({
      this.id, 
      this.judul,
      this.penulis, 
      this.penerbit, 
      this.tahunTerbit,
      this.deskripsiBuku,
      this.sampulBuku,
      this.rating,
  });

  DataBook.fromJson(dynamic json) {
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
    final map = <String, dynamic>{};
    map['id'] = id;
    map['judul'] = judul;
    map['penulis'] = penulis;
    map['penerbit'] = penerbit;
    map['tahun_terbit'] = tahunTerbit;
    map['deskripsi_buku'] = deskripsiBuku;
    map['sampul_buku'] = sampulBuku;
    map['rating'] = rating;
    return map;
  }

}
