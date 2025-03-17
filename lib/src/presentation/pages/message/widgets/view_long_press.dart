part of '../message.dart';

class ViewLongPress extends StatelessWidget {
  final ChatMessage data;
  final Function() onDeleteMessage;
  final Function(String) onPickEmoji;
  final Function() onForwardMessage;
  final Function() onReplyMessage;
  const ViewLongPress({super.key, required this.data, required this.onDeleteMessage, required this.onPickEmoji, required this.onReplyMessage, required this.onForwardMessage});

  @override
  Widget build(BuildContext context) {
    bool isMe = data.senderUser?.userid == context.read<UserCubit>().state.user.id;

    List<String> emojis = [
      AppAsset.icons.emojiTongue.path,
      AppAsset.icons.emojiLove.path,
      AppAsset.icons.emojiAngry.path,
      AppAsset.icons.emojiKiss.path,
      AppAsset.icons.emojiCrying.path,
      AppAsset.icons.emojiParty.path,
    ];
    return GestureDetector(
      onTap: DNavigator.back,
      child: Container(
        decoration: BoxDecoration(color: Color(0xffF3F3F3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 220.sp,
                    margin: EdgeInsets.symmetric(horizontal: 10.sp),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(emojis.length, (index) {
                        return GestureDetector(
                            onTap: () {
                              onPickEmoji(emojis[index]);
                            },
                            child: Image.asset(emojis[index],
                              width: 24.sp,height: 24.sp,
                              fit: BoxFit.cover,
                            ));
                      }),
                    ),
                  ),
                ),
                10.verticalSpace,
                ItemMessage(data),
              ],
            ),
            _bottom(context)
          ],
        ),
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    // final cubit = context.read<MessageCubit>();
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _module(
              AppAsset.images.reply.path, "Trả lời",
              onTap: onReplyMessage),
          _module(
              AppAsset.images.forward.path, "Chuyển tiếp",
              onTap: onForwardMessage),
          if(data.msgType == FirebaseRes.msg)  _module(
              AppAsset.images.compare.path, "Sao chép",
              onTap: () async {
                DNavigator.back();
                await Clipboard.setData(ClipboardData(text: data.msg ?? ""));
              }),
          _module(
              AppAsset.images.trash.path, "Xóa",
              onTap: onDeleteMessage),
        ],
      ),
    );
  }

  Widget _module (String icon, String title,{required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.sp, height: 40.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.sp)
            ),
            child: Image.asset(icon, width: 20.sp, height: 20.sp, fit: BoxFit.contain,),
          ),
          8.verticalSpace,
          AppText(title, style: AppStyle.text12)
        ],
      ),
    );
  }
}
