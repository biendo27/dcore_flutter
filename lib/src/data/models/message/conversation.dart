part of '../models.dart';

class Conversation {
  String? _id; // ID của document
  bool? _block;
  bool? _blockFromOther;
  String? _conversationId;
  String? _deletedId;
  bool? _isDeleted;
  double? _pinTime;
  bool? _isMute;
  bool? _turnOffNotification;
  String? _lastMsg;
  String? _newMsg;
  double? _time;
  ChatUser? _user;
  bool? _isRead; // Trạng thái đã đọc
  bool? _isTyping; // Trạng thái đang gõ

  // Constructor
  Conversation({
    String? id,
    String? conversationId,
    bool? blockFromOther,
    bool? block,
    String? deletedId,
    bool? isDeleted,
    bool? isMute,
    bool? turnOffNotification,
    String? lastMsg,
    String? newMsg,
    double? pinTime,
    ChatUser? user,
    double? time,
    bool? isRead,
    bool? isTyping,
  }) {
    _id = id;
    _conversationId = conversationId;
    _blockFromOther = blockFromOther;
    _block = block;
    _deletedId = deletedId;
    _isDeleted = isDeleted;
    _isMute = isMute;
    _turnOffNotification = turnOffNotification;
    _lastMsg = lastMsg;
    _newMsg = newMsg;
    _pinTime = pinTime;
    _user = user;
    _time = time;
    _isRead = isRead ?? false; // Mặc định là chưa đọc
    _isTyping = isTyping ?? false; // Mặc định là không gõ
  }

  // Tạo đối tượng từ JSON
  Conversation.fromJson(Map<String, dynamic> json) {
    _id = json["id"]; // Lấy ID từ JSON
    _conversationId = json["conversationId"];
    _blockFromOther = json["blockFromOther"];
    _block = json["block"];
    _deletedId = json["deletedId"];
    _isDeleted = json["isDeleted"];
    _isMute = json["isMute"];
    _turnOffNotification = json["turnOffNotification"];
    _lastMsg = json["lastMsg"];
    _newMsg = json["newMsg"];
    _pinTime = json["pinTime"];
    _time = json["time"];
    _isRead = json["isRead"] ?? false;
    _isTyping = json["isTyping"] ?? false;
    _user = json["user"] != null ? ChatUser.fromJson(json["user"]) : null;
  }

  // Chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      "id": _id, // Ghi ID vào JSON
      "conversationId": _conversationId,
      "blockFromOther": _blockFromOther,
      "block": _block,
      "deletedId": _deletedId,
      "isDeleted": _isDeleted,
      "isMute": _isMute,
      "turnOffNotification": _turnOffNotification,
      "lastMsg": _lastMsg,
      "newMsg": _newMsg,
      "pinTime": _pinTime,
      "time": _time,
      "isRead": _isRead,
      "isTyping": _isTyping,
      "user": _user?.toJson(),
    };
  }

  // Getters và Setters
  String? get id => _id;

  void setId(String? id) {
    _id = id;
  }

  String? get conversationId => _conversationId;

  void setConversationId(String? conversationId) {
    _conversationId = conversationId;
  }

  bool? get blockFromOther => _blockFromOther;

  bool? get block => _block;

  ChatUser? get user => _user;

  double? get time => _time;

  String? get newMsg => _newMsg;

  double? get pinTime => _pinTime;

  bool? get turnOffNotification => _turnOffNotification;

  String? get lastMsg => _lastMsg;

  bool? get isMute => _isMute;

  bool? get isDeleted => _isDeleted;

  String? get deletedId => _deletedId;

  bool? get isRead => _isRead;

  void setIsRead(bool? value) {
    _isRead = value;
  }

  bool? get isTyping => _isTyping;

  void setIsTyping(bool? value) {
    _isTyping = value;
  }
}
