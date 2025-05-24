part of '../message.dart';

class MessagePage extends StatefulWidget {
  final Conversation conversation;
  const MessagePage({super.key, required this.conversation});

  static String notificationID = '';

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController textMsgController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    MessagePage.notificationID = widget.conversation.conversationId ?? '';
    context.read<MessageCubit>().initFireStore(widget.conversation, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessageCubit>();
    final user = context.read<UserCubit>().state.user;
    return Scaffold(
      key: _key,
      endDrawer: Setting(conversation: widget.conversation),
      drawerEnableOpenDragGesture: false,
      backgroundColor: Color(0xffF3F3F3),
      body: BlocListener<MessageCubit, MessageState>(
        listener: (context, state) {
          if (state.scrollToEnd) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              }
            });
          }
        },
        child: BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
          return GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: Column(
              children: [
                TopBarArea(
                    onTapAdd: () {
                      _key.currentState?.openEndDrawer();
                    },
                    conversation: widget.conversation),
                ChatArea(chatData: state.chatData, receiverProfile: widget.conversation, scrollController: scrollController),
                BottomBar(
                  msgController: textMsgController,
                  isBlocked: state.isBlock,
                  isBlockFromOther: widget.conversation.blockFromOther ?? false,
                  onShareBtnTap: () {
                    if (textMsgController.text.isNotEmpty) {
                      cubit.onSendMessage(sender: user, conversation: widget.conversation, msgType: FirebaseRes.msg, value: textMsgController.text);
                      textMsgController.clear();
                      cubit.onCloseMessage();
                    }
                  },
                  onCameraTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return CameraBtn(callBackCameraBtn: (btnIndex) {
                          if (btnIndex == 0) {
                            cubit.onCameraTap(context, user, widget.conversation);
                          } else if (btnIndex == 1) {
                            cubit.onImageClick(context, user, widget.conversation);
                          } else if (btnIndex == 2) {
                            cubit.onVideoClick(context, user, widget.conversation);
                          } else {
                            DNavigator.back();
                          }
                        });
                      },
                    );
                  },
                  // timeStamp: timeStamp,
                  // onDeleteBtnClick: onDeleteBtnClick,
                  // cancelBtnClick: onCancelBtnClick,
                  // onAddBtnTap: () {
                  //   if (isBlockFromOther == true) {
                  //     debugPrint("CommonUI.showToast(msg: LKey.youAreBlockFromOther.tr)");
                  //   } else {
                  //     onAddBtnTap();
                  //   }
                  // },
                ),
                5.verticalSpace,
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    // context.read<MessageCubit>().dispose();
    MessagePage.notificationID = '';
    AppConfig.context!.read<MessageCubit>().clearMessage();
    AppConfig.context!.read<MessageCubit>().cancelChatSubscription();
    super.dispose();
  }
}
