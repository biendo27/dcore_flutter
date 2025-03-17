// ignore_for_file: unnecessary_getters_setters

part of '../models.dart';

class ChatUser {
  int? _userid;
  String? _username;
  String? _userFullName;
  String? _image;
  String? _userIdentity;
  bool? _isVerified;
  bool? _isNewMsg;
  double? _date;
  int? _totalFollowing;
  int? _totalFollower;
  String? _tokenFcm;
  bool? _isOnline; // Trạng thái trực tuyến
  bool? _lastMessageRead; // Trạng thái đã đọc tin nhắn cuối

  ChatUser({
    String? username,
    String? userFullName,
    String? image,
    String? userIdentity,
    bool? isVerified,
    bool? isNewMsg,
    int? userid,
    double? date,
    int? totalFollowing,
    int? totalFollower,
    String? tokenFcm,
    bool? isOnline,
    bool? lastMessageRead,
  }) {
    _username = username;
    _userFullName = userFullName;
    _image = image;
    _userIdentity = userIdentity;
    _isVerified = isVerified;
    _isNewMsg = isNewMsg;
    _userid = userid;
    _date = date;
    _totalFollowing = totalFollowing;
    _totalFollower = totalFollower;
    _tokenFcm = tokenFcm;
    _isOnline = isOnline ?? false; // Mặc định là không trực tuyến
    _lastMessageRead = lastMessageRead ?? false; // Mặc định là chưa đọc tin nhắn cuối
  }

  // Chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      "username": _username,
      "userFullName": _userFullName,
      "image": _image,
      "userIdentity": _userIdentity,
      "isVerified": _isVerified,
      "isNewMsg": _isNewMsg,
      "userid": _userid,
      "date": _date,
      "totalFollowing": _totalFollowing,
      "totalFollower": _totalFollower,
      "tokenFcm": _tokenFcm,
      "isOnline": _isOnline,
      "lastMessageRead": _lastMessageRead,
    };
  }

  // Tạo đối tượng từ JSON
  ChatUser.fromJson(Map<String, dynamic> json) {
    _username = json["username"];
    _userFullName = json["userFullName"];
    _image = json["image"];
    _userIdentity = json["userIdentity"];
    _isVerified = json["isVerified"];
    _isNewMsg = json["isNewMsg"];
    _userid = json["userid"];
    _date = json["date"];
    _tokenFcm = json["tokenFcm"];
    _totalFollowing = json["totalFollowing"];
    _totalFollower = json["totalFollower"];
    _isOnline = json["isOnline"] ?? false;
    _lastMessageRead = json["lastMessageRead"] ?? false;
  }

  // Getter và Setter
  String? get tokenFcm => _tokenFcm;

  set tokenFcm(String? value) {
    _tokenFcm = value;
  }

  int? get totalFollowing => _totalFollowing;

  set totalFollowing(int? value) {
    _totalFollowing = value;
  }

  int? get totalFollower => _totalFollower;

  set totalFollower(int? value) {
    _totalFollower = value;
  }

  double? get date => _date;

  set date(double? value) {
    _date = value;
  }

  bool? get isNewMsg => _isNewMsg;

  set isNewMsg(bool? value) {
    _isNewMsg = value;
  }

  bool? get isVerified => _isVerified;

  set isVerified(bool? value) {
    _isVerified = value;
  }

  String? get userIdentity => _userIdentity;

  set userIdentity(String? value) {
    _userIdentity = value;
  }

  String? get image {
    String url = _image ?? '';
    if (url.startsWith('https://venusshop.top/public/assets')) return url;
    if (url.startsWith('https://vnsconnect-live.s3.ap-southeast-2.amazonaws.com/')) {
      url = url.substring('https://vnsconnect-live.s3.ap-southeast-2.amazonaws.com/'.length);
    }
    return url;
  }

  set image(String? value) {
    _image = value;
  }

  String? get userFullName => _userFullName;

  set userFullName(String? value) {
    _userFullName = value;
  }

  String? get username => _username;

  set username(String? value) {
    _username = value;
  }

  int? get userid => _userid;

  set userid(int? value) {
    _userid = value;
  }

  bool? get isOnline => _isOnline;

  set isOnline(bool? value) {
    _isOnline = value;
  }

  bool? get lastMessageRead => _lastMessageRead;

  set lastMessageRead(bool? value) {
    _lastMessageRead = value;
  }
}
