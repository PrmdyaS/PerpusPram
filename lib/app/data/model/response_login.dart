class ResponseLogin {
  ResponseLogin({
      this.status,
      this.message,
      this.data,
  });

  ResponseLogin.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  DataLogin? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class DataLogin {
  DataLogin({
      this.id, 
      this.email,
      this.password,
      this.username,
      this.namaLengkap,
      this.alamat,
      this.noHp,
      this.indexLevelRoles,
      this.profilePicture,
  });

  DataLogin.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    indexLevelRoles = json['index_level_roles'];
    profilePicture = json['profile_picture'];
  }
  String? id;
  String? email;
  String? password;
  String? username;
  String? namaLengkap;
  String? alamat;
  String? noHp;
  String? indexLevelRoles;
  String? profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['username'] = username;
    map['nama_lengkap'] = namaLengkap;
    map['alamat'] = alamat;
    map['no_hp'] = noHp;
    map['index_level_roles'] = indexLevelRoles;
    map['profile_picture'] = profilePicture;
    return map;
  }

}