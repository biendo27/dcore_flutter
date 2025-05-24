part of '../message.dart';

class MessageStorePage extends StatefulWidget {
  final Conversation conversation;
  const MessageStorePage({super.key, required this.conversation});

  static String notificationID = '';

  @override
  State<MessageStorePage> createState() => _MessageStorePageState();
}

class _MessageStorePageState extends State<MessageStorePage> {
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
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        },
        child: BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
          return GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, bottom: 8.sp),
                  child: Visibility(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 26.sp,
                            color: Colors.black,
                          ),
                          onPressed: DNavigator.back,
                        ),
                        15.horizontalSpace,
                        BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                          String image = (widget.conversation.user?.image ?? "").contains("https")
                              ? widget.conversation.user!.image!
                              : ConstRes.itemBaseUrl + (widget.conversation.user?.image ?? '');
                          return Expanded(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: DCachedImage(
                                    height: 37.sp,
                                    width: 37.sp,
                                    fit: BoxFit.cover,
                                    url: image,
                                  ),
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: AppText(
                                              widget.conversation.user?.userFullName ?? 'aaa',
                                              style: AppStyle.text16.copyWith(overflow: TextOverflow.ellipsis),
                                              maxLines: 1,
                                            ),
                                          ),
                                          5.horizontalSpace,
                                          Flexible(
                                            child: Visibility(
                                              visible: widget.conversation.user?.isVerified ?? false,
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppText(context.text.activity,
                                              style: AppStyle.text12.copyWith(overflow: TextOverflow.ellipsis),
                                              maxLines: 1),
                                          4.horizontalSpace,
                                          Container(
                                            height: 8.sp,
                                            width: 8.sp,
                                            decoration: BoxDecoration(
                                                color: Colors.green, borderRadius: BorderRadius.circular(8)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                ChatAreaStore(
                    chatData: state.chatData, receiverProfile: widget.conversation, scrollController: scrollController),
                BottomBar(
                  msgController: textMsgController,
                  isBlocked: state.isBlock,
                  isBlockFromOther: widget.conversation.blockFromOther ?? false,
                  onShareBtnTap: () {
                    if (textMsgController.text.isNotEmpty) {
                      cubit.onSendMessage(
                          sender: user,
                          conversation: widget.conversation,
                          msgType: FirebaseRes.msg,
                          value: textMsgController.text);
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
    super.dispose();
  }
}
