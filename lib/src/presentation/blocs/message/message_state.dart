part of '../blocs.dart';

class MessageState {
  final bool isLoading; // Trạng thái tải dữ liệu
  final List<Conversation> conversation; // Danh sách cuộc trò chuyện
  final Map<String, List<ChatMessage>> chatData; // Dữ liệu tin nhắn nhóm theo ngày
  final bool isBlock; // Trạng thái chặn
  final bool turnOffNotification; // Tắt thông báo
  final bool isPin; // Đánh dấu ghim
  final String replying; // Nội dung trả lời
  final bool scrollToEnd; // Tự động cuộn tới cuối danh sách tin nhắn
  final int unreadCount; // Số lượng tin nhắn chưa đọc
  final bool isTyping; // Trạng thái đang gõ
  final bool isLongPress; // Trạng thái nhấn giữ

  MessageState({
    required this.isLoading,
    required this.conversation,
    required this.chatData,
    required this.isBlock,
    required this.turnOffNotification,
    required this.isPin,
    required this.replying,
    required this.scrollToEnd,
    required this.unreadCount,
    required this.isTyping,
    required this.isLongPress,
  });

  // Trạng thái ban đầu
  factory MessageState.initial() => MessageState(
        isLoading: false,
        conversation: [],
        chatData: {},
        isBlock: false,
        turnOffNotification: false,
        isPin: false,
        replying: '',
        scrollToEnd: false,
        unreadCount: 0,
        isTyping: false,
        isLongPress: false, // Mặc định không nhấn giữ
      );

  // Tạo bản sao của state với các giá trị mới
  MessageState copyWith({
    bool? isLoading,
    List<Conversation>? conversation,
    Map<String, List<ChatMessage>>? chatData,
    bool? isBlock,
    bool? turnOffNotification,
    bool? isPin,
    String? replying,
    bool? scrollToEnd,
    int? unreadCount,
    bool? isTyping,
    bool? isLongPress, // Bổ sung thuộc tính mới
  }) {
    return MessageState(
      isLoading: isLoading ?? this.isLoading,
      conversation: conversation ?? this.conversation,
      chatData: chatData ?? this.chatData,
      isBlock: isBlock ?? this.isBlock,
      turnOffNotification: turnOffNotification ?? this.turnOffNotification,
      isPin: isPin ?? this.isPin,
      replying: replying ?? this.replying,
      scrollToEnd: scrollToEnd ?? this.scrollToEnd,
      unreadCount: unreadCount ?? this.unreadCount,
      isTyping: isTyping ?? this.isTyping,
      isLongPress: isLongPress ?? this.isLongPress, // Copy trạng thái nhấn giữ
    );
  }
}

class FirebaseRes {
  static const String userChatList = 'userChatList'; // Danh sách trò chuyện của người dùng
  static const String userList = 'userList'; // Danh sách người dùng
  static const String time = 'time'; // Thời gian tin nhắn
  static const String lastMsg = 'lastMsg'; // Nội dung tin nhắn cuối
  static const String image = 'image'; // Hình ảnh trong tin nhắn
  static const String video = 'video'; // Video trong tin nhắn
  static const String user = 'user'; // Thông tin người dùng
  static const String chat = 'chat'; // Tên collection chat
  static const String chatList = 'chatList'; // Danh sách chat
  static const String blockFromOther = 'blockFromOther'; // Trạng thái chặn từ người khác
  static const String block = 'block'; // Trạng thái chặn
  static const String replyTo = 'replyTo'; // Trả lời tin nhắn
  static const String pinTime = 'pinTime'; // Thời gian ghim
  static const String turnOffNotification = 'turnOffNotification'; // Tắt thông báo
  static const String emoji = 'emoji'; // Biểu tượng cảm xúc
  static const String noDeletedId = 'not_deleted_identities'; // ID không bị xóa
  static const String isRead = 'isRead'; // Trạng thái đã đọc
  static const String isTyping = 'isTyping'; // Trạng thái đang gõ
  static const String liveStreamUser = 'liveStreamUser'; // Người dùng trong live stream
  static const String id = 'id'; // ID chung
  static const String comment = 'comment'; // Bình luận
  static const String watchingCount = 'watchingCount'; // Số người đang xem
  static const String collectedDiamond = 'collectedDiamond'; // Số kim cương thu thập
  static const String timing = 'timing'; // Thời gian
  static const String watching = 'watching'; // Trạng thái đang xem
  static const String collected = 'collected'; // Trạng thái thu thập
  static const String profileImage = 'profileImage'; // Ảnh đại diện
  static const String joinedUser = 'joinedUser'; // Người dùng đã tham gia
  static const String isDeleted = 'isDeleted'; // Trạng thái đã xóa
  static const String deletedId = 'deletedId'; // ID tin nhắn đã xóa
  static const String msg = 'msg'; // Nội dung tin nhắn
}

class ConstRes {
  static final String itemBaseUrl = 'https://vnsconnect-live.s3.ap-southeast-2.amazonaws.com/';
}
