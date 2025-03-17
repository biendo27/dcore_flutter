part of '../message.dart';

class ChatArea extends StatelessWidget {
  final Map<String, List<ChatMessage>>? chatData;
  final Conversation receiverProfile;
  final ScrollController scrollController;

  const ChatArea({super.key, required this.chatData, required this.receiverProfile, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            _info(),
            ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: chatData != null ? chatData?.keys.length : 0,
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 8.sp),
              itemBuilder: (context, index) {
                String? date = chatData?.keys.elementAt(index) ?? '';
                List<ChatMessage>? messages = chatData?[date];
                return Column(
                  children: [
                    _alertView(data: date),
                    ListView.builder(
                      itemCount: messages?.length,
                      reverse: true,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemBuilder: (context, index) {
                        return ItemMessage(messages?[index], onLongPress: () => onLongPress(messages![index], context));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onLongPress(ChatMessage data, BuildContext context) {
    final cubit = context.read<MessageCubit>();
    final user = context.read<UserCubit>().state.user;
    final timeStamp = data.senderUser?.date?.toInt().toString() ?? "";
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 1,
      enableDrag: false,
      initialChildSize: 1,
      bodyWidget: ViewLongPress(
        data: data,
        onDeleteMessage: () {
          cubit.onDeleteMessage(user, timeStamp);
          DNavigator.back();
        },
        onPickEmoji: (emoji) {
          cubit.onPickEmoji(emoji, timeStamp);
          DNavigator.back();
        },
        onReplyMessage: () {
          cubit.onReplyMessage(data.msgType == FirebaseRes.msg
              ? data.msg!
              : data.msgType == FirebaseRes.image
                  ? "Trả lời một hình ảnh"
                  : "Trả lời một video");
          DNavigator.back();
        },
        onForwardMessage: () {
          // cubit.forwardMessage(
          //   receiverUser: receiverUser,
          //   context: context,
          //   msgType: msgType,
          //   textMessage: ,
          //   image: ,
          //   video: ,
          // );
        },
      ),
    );
  }

  Widget _alertView({required String data}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: AppText(data, style: AppStyle.text12.copyWith(color: Colors.black.op(0.75))),
    );
  }

  Widget _info() {
    String image = (receiverProfile.user?.image ?? "").contains("https") ? receiverProfile.user!.image! : ConstRes.itemBaseUrl + (receiverProfile.user?.image ?? '');
    return SizedBox(
      child: Column(
        children: [
          20.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(120.sp),
            child: DCachedImage(
              height: 120.sp,
              width: 120.sp,
              fit: BoxFit.cover,
              url: image,
            ),
          ),
          8.verticalSpace,
          AppText(receiverProfile.user?.userFullName ?? "", style: AppStyle.text20.copyWith(fontWeight: FontWeight.w600)),
          AppText(
            receiverProfile.user?.username ?? "",
            style: AppStyle.text14.copyWith(color: Colors.black.op(0.75)),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppStyle.text14.copyWith(color: Colors.black.op(0.75)),
              children: [
                TextSpan(text: "${receiverProfile.user?.totalFollowing ?? "0"} đang follow"),
                TextSpan(
                  text: " | ",
                ),
                TextSpan(
                  text: "${receiverProfile.user?.totalFollower ?? "0"} follow",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
