part of '../models.dart';

class ChatMessage {
  String? _id;
  String? _image;
  String? _video;
  String? _msg;
  String? _msgType;
  String? _emoji;
  String? _replyTo;
  double? _time;
  bool? _isRead; // Thêm trạng thái đã đọc
  List<String>? _notDeletedIdentities;
  ChatUser? _senderUser;

  ChatMessage({
    String? id,
    String? image,
    String? video,
    String? msg,
    String? msgType,
    double? time,
    String? replyTo,
    String? emoji,
    ChatUser? senderUser,
    List<String>? notDeletedIdentities,
    bool? isRead, // Trạng thái đã đọc
  }) {
    _id = id;
    _image = image;
    _video = video;
    _msg = msg;
    _msgType = msgType;
    _time = time;
    _senderUser = senderUser;
    _emoji = emoji;
    _replyTo = replyTo;
    _notDeletedIdentities = notDeletedIdentities;
    _isRead = isRead ?? false; // Mặc định là chưa đọc
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "image": _image,
      "video": _video,
      "msg": _msg,
      "msgType": _msgType,
      "time": _time,
      "emoji": _emoji,
      "replyTo": _replyTo,
      "isRead": _isRead, // Thêm vào JSON
      "senderUser": _senderUser?.toJson(),
      "not_deleted_identities": _notDeletedIdentities?.map((v) => v).toList()
    };
  }

  ChatMessage.fromJson(Map<String, dynamic>? json) {
    _id = json?["id"];
    _image = json?["image"];
    _video = json?["video"];
    _msg = json?["msg"];
    _msgType = json?["msgType"];
    _time = json?["time"];
    _emoji = json?["emoji"];
    _replyTo = json?["replyTo"];
    _isRead = json?["isRead"] ?? false; // Đọc từ JSON
    _senderUser = ChatUser.fromJson(json?["senderUser"]);
    if (json?['not_deleted_identities'] != null) {
      _notDeletedIdentities = [];
      json?['not_deleted_identities'].forEach((v) {
        _notDeletedIdentities?.add(v);
      });
    }
  }

  factory ChatMessage.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<String> notDeletedIdentities = [];
    data?['not_deleted_identities'].forEach((v) {
      notDeletedIdentities.add(v);
    });
    return ChatMessage(
      id: data?['id'],
      image: data?['image'],
      video: data?['video'],
      msg: data?['msg'],
      replyTo: data?['replyTo'],
      emoji: data?['emoji'],
      msgType: data?['msgType'],
      time: data?['time'],
      isRead: data?['isRead'] ?? false, // Đọc từ Firestore
      notDeletedIdentities: notDeletedIdentities,
      senderUser: ChatUser.fromJson(data?["senderUser"]),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (id != null) "id": _id,
      if (image != null) "image": _image,
      if (video != null) "video": _video,
      if (msg != null) "msg": _msg,
      if (msgType != null) "msgType": _msgType,
      if (time != null) "time": _time,
      if (replyTo != null) "replyTo": _replyTo,
      if (emoji != null) "emoji": _emoji,
      if (isRead != null) "isRead": _isRead, // Ghi vào Firestore
      if (senderUser != null) "senderUser": _senderUser?.toJson(),
      if (notDeletedIdentities != null) "not_deleted_identities": _notDeletedIdentities?.map((v) => v).toList()
    };
  }

  // Getter cho trạng thái đã đọc
  bool? get isRead => _isRead;

  // Các getter khác
  String? get video => _video;
  List<String>? get notDeletedIdentities => _notDeletedIdentities;
  ChatUser? get senderUser => _senderUser;
  double? get time => _time;
  String? get msgType => _msgType;
  String? get msg => _msg;
  String? get emoji => _emoji;
  String? get replyTo => _replyTo;
  String? get image => _image;
  String? get id => _id;
}
