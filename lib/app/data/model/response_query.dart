/// message : "success"
/// status : 200
/// data : ["Gadis Kretek","Jujutsu Kaisen 0","Jujutsu Kaisen 05","Jujutsu Kaisen 13","Keep Up with Us!","Komi Sulit Berkomunikasi 18","Regarding Reincarnated to Slime 12"]

class ResponseQuery {
  ResponseQuery({
      this.message, 
      this.status, 
      this.data,});

  ResponseQuery.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  String? message;
  int? status;
  List<String>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    map['data'] = data;
    return map;
  }

}