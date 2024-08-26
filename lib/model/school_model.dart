class schoolModel {
  bool? status;
  String? message;
  Data? data;

  schoolModel({this.status, this.message, this.data});

  schoolModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? email;
  String? phone;
  String? address;
  String? schoolInfo;
  int? sessionId;
  String? session;
  String? schoolLogo;
  String? createdAt;
  String? photopath;

  Data(
      {this.title,
      this.email,
      this.phone,
      this.address,
      this.schoolInfo,
      this.sessionId,
      this.session,
      this.schoolLogo,
      this.createdAt,
      this.photopath});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    schoolInfo = json['school_info'];
    sessionId = json['session_id'];
    session = json['session'];
    schoolLogo = json['school_logo'];
    createdAt = json['created_at'];
    photopath = json['photopath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['school_info'] = this.schoolInfo;
    data['session_id'] = this.sessionId;
    data['session'] = this.session;
    data['school_logo'] = this.schoolLogo;
    data['created_at'] = this.createdAt;
    data['photopath'] = this.photopath;
    return data;
  }
}
