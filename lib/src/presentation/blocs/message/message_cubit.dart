part of '../blocs.dart';

@lazySingleton
class MessageCubit extends Cubit<MessageState> with CubitActionMixin<MessageState> {
  final db.FirebaseFirestore _db = db.FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  final IUploadRepository _uploadRepository;
  final INotificationRepository _iNotificationRepository;

  MessageCubit(this._uploadRepository, this._iNotificationRepository) : super(MessageState.initial());

  late db.DocumentReference _drReceiver;
  late db.DocumentReference _drSender;
  late db.CollectionReference _drChatMessage;
  StreamSubscription<db.QuerySnapshot<Conversation>>? _listMessageSubscription;
  StreamSubscription<db.QuerySnapshot<ChatMessage>>? _chatSubscription;
  Conversation? conversationReceiver;
  Map<String, List<ChatMessage>>? _grouped;
  ChatUser? _receiverUser;
  List<ChatMessage> _chatData = [];

  void getListMessage(AppUser user) {
    _listMessageSubscription = _db
        .collection(FirebaseRes.userChatList)
        // .doc("huysoft23@gmail.com")
        .doc(user.phone)
        .collection(FirebaseRes.userList)
        .where(FirebaseRes.isDeleted, isEqualTo: false)
        .orderBy(FirebaseRes.time, descending: true)
        .withConverter(
          fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .snapshots()
        .listen((data) {
      List<Conversation> conversations = [];
      List<Conversation> listPin = [];

      for (var ele in data.docs) {
        debugPrint("asasvvasv 123123213");
        debugPrint('${ele.data().toJson()}');
        if (ele.data().pinTime != null) {
          listPin.add(ele.data());
        } else {
          conversations.add(ele.data());
        }
      }

      listPin.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(a.pinTime!.toInt()).compareTo(DateTime.fromMillisecondsSinceEpoch(b.pinTime!.toInt())));
      conversations = [...listPin, ...conversations];

      for (var e in conversations) {
        debugPrint("123123 ${e.user?.toJson()}");
      }
      emit(state.copyWith(conversation: conversations));
    });
  }

  Future<void> initFireStore(Conversation conversation, BuildContext context) async {
    final user = context.read<UserCubit>().state.user;
    _drReceiver = _db.collection(FirebaseRes.userChatList).doc(conversation.user?.userIdentity).collection(FirebaseRes.userList).doc(user.phone);

    _drSender = _db.collection(FirebaseRes.userChatList).doc(user.phone).collection(FirebaseRes.userList).doc(conversation.user?.userIdentity);

    await _drReceiver
        .withConverter(fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!), toFirestore: (Conversation value, options) => value.toJson())
        .get()
        .then((value) {
      conversationReceiver = value.data();
      _receiverUser = value.data()?.user;
    });

    await _drSender
        .withConverter(fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!), toFirestore: (Conversation value, options) => value.toJson())
        .get()
        .then(
      (value) async {
        if (value.data() != null && value.data()?.conversationId != null) {
          conversation.setConversationId(value.data()?.conversationId);
        }
        _drChatMessage = _db.collection(FirebaseRes.chat).doc(conversation.conversationId).collection(FirebaseRes.chat);
        _getChat(user, isBlock: value.data()?.block ?? false, turnOffNotification: value.data()?.turnOffNotification ?? false, isPin: value.data()?.pinTime != null);
      },
    );
  }

  /// Using when navigate from profile other user
  void onChatProfile(AppUser profile) {
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    var myProfile = AppConfig.context!.read<UserCubit>().state.user;
    final myIdentity = myProfile.phone;
    final userIdentity = profile.phone;
    ChatUser chatUser = ChatUser(
        date: time,
        image: profile.image,
        isNewMsg: false,
        isVerified: false,
        userFullName: profile.name,
        userid: profile.id,
        totalFollower: profile.totalFollower,
        totalFollowing: profile.totalFollowing,
        // tokenFcm: profile.tokenFcm,
        userIdentity: userIdentity,
        username: profile.username);
    Conversation conversation =
        Conversation(user: chatUser, block: false, blockFromOther: false, conversationId: '$userIdentity$myIdentity', isDeleted: false, isMute: false, time: time);
    DNavigator.goNamed(RouteNamed.message, extra: conversation);
  }

  void onChatStore(AppUser profile) {
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    var myProfile = AppConfig.context!.read<UserCubit>().state.user;
    final myIdentity = myProfile.phone;
    final userIdentity = profile.phone;
    ChatUser chatUser = ChatUser(
        date: time,
        image: profile.image,
        isNewMsg: false,
        isVerified: false,
        userFullName: profile.name,
        userid: profile.id,
        totalFollower: profile.totalFollower,
        totalFollowing: profile.totalFollowing,
        // tokenFcm: profile.tokenFcm,
        userIdentity: userIdentity,
        username: profile.username);
    Conversation conversation =
        Conversation(user: chatUser, block: false, blockFromOther: false, conversationId: '$userIdentity$myIdentity', isDeleted: false, isMute: false, time: time);
    DNavigator.goNamed(RouteNamed.messageStore, extra: conversation);
  }

  void onCameraTap(BuildContext context, AppUser sender, Conversation conversation) async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (image == null || image.path.isEmpty) return;
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(image.path)],
    );
    _firebaseSendMessage(msgType: FirebaseRes.image, image: response.data.first.url, sender: sender, conversation: conversation);
  }

  void onImageClick(BuildContext context, AppUser sender, Conversation conversation) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null || image.path.isEmpty) return;
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(image.path)],
    );
    _firebaseSendMessage(msgType: FirebaseRes.image, image: response.data.first.url, sender: sender, conversation: conversation);
  }

  void onVideoClick(BuildContext context, AppUser sender, Conversation conversation) async {
    File? videos;
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery, maxDuration: Duration(seconds: 30));
    if (video == null || video.path.isEmpty) return;

    /// calculating file size
    videos = File(video.path);
    int sizeInBytes = videos.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    if (sizeInMb <= 15) {
      await VideoThumbnail.thumbnailFile(video: videos.path).then(
        (value) async {
          final BaseResponseList<AppFile> responseImg = await _uploadRepository.uploadFile(
            UploadType.postImage,
            [File(value.path)],
          );
          final BaseResponseList<AppFile> responseVideo = await _uploadRepository.uploadFile(
            UploadType.postVideo,
            [videos!],
          );
          _firebaseSendMessage(video: responseVideo.data.first.url, msgType: FirebaseRes.video, image: responseImg.data.first.url, sender: sender, conversation: conversation);
        },
      );
    }
  }

  void onSendMessage({
    required AppUser sender,
    required Conversation conversation,
    required String msgType,
    required String value,
  }) =>
      _firebaseSendMessage(
        msgType: FirebaseRes.msg,
        textMessage: value,
        sender: sender,
        conversation: conversation,
      );

  void blockOrUnblock({required bool isBlock}) {
    _drReceiver
        .withConverter(
      fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!),
      toFirestore: (Conversation value, options) => value.toJson(),
    )
        .update({FirebaseRes.blockFromOther: isBlock});

    _drSender
        .withConverter(
      fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!),
      toFirestore: (Conversation value, options) => value.toJson(),
    )
        .update({FirebaseRes.block: isBlock});

    emit(state.copyWith(isBlock: isBlock));
  }

  void onCloseMessage() {
    emit(state.copyWith(replying: ''));
  }

  void onReplyMessage(String message) {
    emit(state.copyWith(replying: message));
  }

  void onPickEmoji(String emoji, String timeStamp) {
    _drChatMessage.doc(timeStamp).update(
      {FirebaseRes.emoji: emoji},
    );
  }

  void handleNotification(bool value) {
    _drSender
        .withConverter(
      fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!),
      toFirestore: (Conversation value, options) => value.toJson(),
    )
        .update(
      {FirebaseRes.turnOffNotification: value},
    );

    emit(state.copyWith(turnOffNotification: value));
  }

  void pinToUser(bool value) {
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    _drSender
        .withConverter(
      fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!),
      toFirestore: (Conversation value, options) => value.toJson(),
    )
        .update({FirebaseRes.pinTime: value ? time : null});

    emit(state.copyWith(isPin: value));
  }

  void forwardMessage({required AppUser receiverUser, required BuildContext context, required String msgType, String? textMessage, String? image, String? video}) {
    final sender = context.read<UserCubit>().state.user;
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    bool isNewChat = false;
    ChatUser chatUser = ChatUser(
        date: time,
        image: receiverUser.image,
        isNewMsg: true,
        isVerified: false,
        userFullName: receiverUser.name,
        userid: receiverUser.id,
        totalFollowing: receiverUser.totalFollowing,
        totalFollower: receiverUser.totalFollower,
        userIdentity: receiverUser.phone,
        username: receiverUser.username);
    Conversation conversation = Conversation(
        user: chatUser,
        block: false,
        blockFromOther: false,
        conversationId: '${receiverUser.phone}${sender.phone}',
        deletedId: '',
        isDeleted: false,
        isMute: false,
        lastMsg: '',
        newMsg: '',
        time: time);
    final drReceiver = _db.collection(FirebaseRes.userChatList).doc(conversation.user?.userIdentity).collection(FirebaseRes.userList).doc(sender.phone);

    final drSender = _db.collection(FirebaseRes.userChatList).doc(sender.phone).collection(FirebaseRes.userList).doc(conversation.user?.userIdentity);

    final drChatMessage = _db.collection(FirebaseRes.chat).doc(conversation.conversationId).collection(FirebaseRes.chat);

    drChatMessage
        .withConverter(fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!), toFirestore: (Conversation value, options) => value.toJson())
        .snapshots()
        .listen((element) {
      if (element.docs.isNotEmpty) isNewChat = false;
    });

    drSender
        .withConverter(fromFirestore: (snapshot, options) => Conversation.fromJson(snapshot.data()!), toFirestore: (Conversation value, options) => value.toJson())
        .get()
        .then((value) async {
      if (value.data() != null && value.data()?.conversationId != null) {
        conversation.setConversationId(value.data()?.conversationId);
      }
      drChatMessage.doc(time.toString()).set(
            ChatMessage(
              notDeletedIdentities: [sender.phone, conversation.user?.userIdentity ?? ''],
              senderUser: ChatUser(
                username: sender.username,
                userFullName: sender.name,
                date: time.toDouble(),
                isNewMsg: true,
                userid: sender.id,
                totalFollower: sender.totalFollower,
                totalFollowing: sender.totalFollowing,
                userIdentity: sender.phone,
                image: sender.image,
              ),
              msgType: msgType,
              msg: textMessage?.trim(),
              image: image,
              video: video,
              id: conversation.user?.userid.toString(),
              time: time.toDouble(),
            ).toJson(),
          );
    });

    if (isNewChat) {
      Map<String, dynamic> con = conversation.toJson();
      con[FirebaseRes.lastMsg] = _getLastMsg(type: msgType, message: textMessage ?? '');
      drSender.set(con);
      drReceiver.set(Conversation(
        block: false,
        blockFromOther: false,
        conversationId: conversation.conversationId,
        deletedId: '',
        isDeleted: false,
        isMute: false,
        lastMsg: _getLastMsg(type: msgType, message: textMessage ?? ''),
        newMsg: textMessage,
        time: time.toDouble(),
        user: ChatUser(
          username: sender.username,
          userIdentity: sender.phone,
          userid: sender.id,
          userFullName: sender.name,
          totalFollower: sender.totalFollower,
          totalFollowing: sender.totalFollowing,
          isNewMsg: false,
          image: sender.image,
          date: time.toDouble(),
        ),
      ).toJson());
    } else {
      drReceiver.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: time.toDouble(),
          FirebaseRes.lastMsg: _getLastMsg(type: msgType, message: textMessage ?? '', userSendImage: chatUser.userFullName ?? "user"),
          FirebaseRes.user: chatUser.toJson(),
        },
      );
      drSender.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: time.toDouble(),
          FirebaseRes.lastMsg: _getLastMsg(type: msgType, message: textMessage ?? '', userSendImage: "Bạn"),
          FirebaseRes.user: conversation.user?.toJson()
        },
      );
    }
  }

  void onDeleteMessage(AppUser user, String timeStamp) {
    _drChatMessage.doc(timeStamp).update(
      {
        FirebaseRes.noDeletedId: db.FieldValue.arrayRemove([user.phone])
      },
    );
  }

  void onLongPress(ChatMessage? data) {
    emit(state.copyWith(isLongPress: true));
  }

  void backLongPress() {
    emit(state.copyWith(isLongPress: false));
  }

  void _getChat(AppUser user, {required bool isBlock, required bool turnOffNotification, required bool isPin}) {
    _chatSubscription = _drChatMessage
        .where(FirebaseRes.noDeletedId, arrayContains: user.phone)
        // .where(FirebaseRes.time,
        // isGreaterThan: deletedId.isEmpty ? 0.0 : double.parse(deletedId))
        .orderBy(FirebaseRes.time, descending: true)
        .withConverter(fromFirestore: ChatMessage.fromFireStore, toFirestore: (ChatMessage value, options) => value.toFireStore())
        .snapshots()
        .listen((element) async {
      _chatData = [];
      for (var ele in element.docs) {
        _chatData.add(ele.data());
      }
      _grouped = groupBy<ChatMessage, String>(_chatData, (message) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(message.time!.toInt());
        return DateFormat("HH:mm dd/MM/yyyy").format(time);
      });

      emit(state.copyWith(isLoading: false, chatData: _grouped, isBlock: isBlock, turnOffNotification: turnOffNotification, isPin: isPin));

      emit(state.copyWith(scrollToEnd: true));
    });
  }

  void _firebaseSendMessage({required AppUser sender, required Conversation conversation, required String msgType, String? textMessage, String? image, String? video}) {
    var time = DateTime.now().millisecondsSinceEpoch;
    final notDeletedIdentity = [sender.phone, conversation.user?.userIdentity ?? ''];

    _drChatMessage.doc(time.toString()).set(
          ChatMessage(
            notDeletedIdentities: notDeletedIdentity,
            senderUser: ChatUser(
              username: sender.username,
              userFullName: sender.name,
              date: time.toDouble(),
              isNewMsg: true,
              userid: sender.id,
              userIdentity: sender.phone,
              image: sender.image,
            ),
            msgType: msgType,
            replyTo: state.replying,
            msg: textMessage?.trim(),
            image: image,
            video: video,
            id: conversation.user?.userid.toString(),
            time: time.toDouble(),
          ).toJson(),
        );

    conversationReceiver = conversationReceiver ??
        Conversation(
          block: false,
          blockFromOther: false,
          conversationId: conversation.conversationId,
          deletedId: '',
          isDeleted: false,
          isMute: false,
          lastMsg: _getLastMsg(type: msgType, message: textMessage ?? ''),
          newMsg: textMessage,
          time: time.toDouble(),
          user: ChatUser(
            username: sender.username,
            userIdentity: sender.phone,
            userid: sender.id,
            userFullName: sender.name,
            totalFollower: sender.totalFollower,
            totalFollowing: sender.totalFollowing,
            isNewMsg: false,
            image: sender.image,
            date: time.toDouble(),
          ),
        );

    if (_chatData.isEmpty) {
      Map con = conversation.toJson();
      con[FirebaseRes.lastMsg] = _getLastMsg(type: msgType, message: textMessage ?? '');
      _drSender.set(con);
      _drReceiver.set(conversationReceiver?.toJson());
    } else {
      _receiverUser?.isNewMsg = true;
      _drReceiver.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: time.toDouble(),
          FirebaseRes.lastMsg: _getLastMsg(type: msgType, message: textMessage ?? '', userSendImage: sender.name),
          // FirebaseRes.user: _receiverUser?.toJson(),
        },
      );
      // sender update
      conversation.user?.isNewMsg = true;
      _drSender.update(
        {
          FirebaseRes.isDeleted: false,
          FirebaseRes.time: time.toDouble(),
          FirebaseRes.lastMsg: _getLastMsg(type: msgType, message: textMessage ?? '', userSendImage: "Bạn"),
          // FirebaseRes.user: conversation.user?.toJson()
        },
      );
    }

    if (conversation.turnOffNotification != true && conversation.blockFromOther == false) {
      String jsonConversationString = jsonEncode(conversationReceiver?.toJson());
      _iNotificationRepository.pushNotificationToSingleUser({
        "user_id": conversation.user?.userid,
        "title": sender.name,
        "message": _getLastMsg(type: msgType, message: textMessage ?? '', userSendImage: sender.name),
        "data": {
          "message": jsonConversationString,
          "notificationID": conversation.conversationId,
        }
      });
    }
  }

  void clearMessage() => _grouped?.clear();

  String _getLastMsg({required String type, required String message, String? userSendImage}) {
    return type == FirebaseRes.image
        ? "$userSendImage đã gửi 1 hình ảnh"
        : type == FirebaseRes.video
            ? "$userSendImage đã gửi 1 video"
            : message;
  }

  Future<void> cancelListMessageSubscription() async => await _listMessageSubscription?.cancel();

  Future<void> cancelChatSubscription() async => await _chatSubscription?.cancel();
}
