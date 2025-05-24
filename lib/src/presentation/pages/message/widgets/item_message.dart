part of '../message.dart';

class ItemMessage extends StatelessWidget {
  final ChatMessage? data;
  final Function()? onLongPress;
  const ItemMessage(this.data, {super.key, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    bool isMe = data?.senderUser?.userid == context.read<UserCubit>().state.user.id;
    String emoji = data?.emoji ?? '';
    String image = (data?.senderUser?.image ?? "").contains("https") ? data!.senderUser!.image! : ConstRes.itemBaseUrl + (data?.senderUser?.image ?? '');
    return Hero(
      tag: data?.time.toString() ?? "",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: emoji.isNotEmpty ? 10.sp : 4.sp),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      Padding(
                        padding: EdgeInsets.only(right: 8.sp),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: DCachedImage(
                            height: 37.sp,
                            width: 37.sp,
                            fit: BoxFit.cover,
                            url: image,
                          ),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(15.sp),
                          //   topRight: Radius.circular(15.sp),
                          //   bottomRight: isMe ? Radius.zero : Radius.circular(15.sp),
                          //   bottomLeft: !isMe ? Radius.zero : Radius.circular(15.sp),
                          // ),
                          borderRadius: BorderRadius.circular(15.sp),
                          color: isMe ? AppCustomColor.orangeF1 : Colors.white),
                      child: data?.msgType == FirebaseRes.image
                          ? imageMessage(data, context)
                          : data?.msgType == FirebaseRes.video
                              ? videoMessage(data, context)
                              : _textMessage(data, context, isMe),
                    ),
                  ],
                ),
                if (emoji.isNotEmpty)
                  Positioned(
                    bottom: -8.sp,
                    right: !isMe ? null : 10.sp,
                    left: isMe ? null : 45.sp,
                    child: _emoji(emoji),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emoji(String emoji) {
    return Container(
        width: 15.sp,
        height: 15.sp,
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.sp)),
        child: Image.asset(
          emoji,
          height: 24.sp,
          width: 24.sp,
        ));
  }

  Widget _textMessage(ChatMessage? data, BuildContext context, bool isMe) {
    return GestureDetector(
      onLongPress: () {
        onLongPress!();
      },
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        width: data!.msg!.length > 40 ? MediaQuery.of(context).size.width * 0.8 : null,
        padding: const EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.replyTo!.isNotEmpty) AppText("| ${data.replyTo!}", style: AppStyle.text14.copyWith(color: Colors.white.op(0.7))),
            AppText(
              data.msg ?? '',
              style: AppStyle.text14.copyWith(color: isMe ? Colors.white : Colors.black),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageMessage(ChatMessage? data, BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPress!();
      },
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _onPress(context, data, ImagePreview(message: data));
            },
            child: DCachedImage(
              url: '${ConstRes.itemBaseUrl}${data?.image}',
              height: 215.sp,
              width: 100.sp,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget videoMessage(ChatMessage? data, BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPress!();
      },
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _onPress(context, data, VideosView(message: data));
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: DCachedImage(
                    url: '${ConstRes.itemBaseUrl}${data?.image}',
                    height: 215.sp,
                    width: 100.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_arrow,
                    size: 28.sp,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPress(BuildContext context, ChatMessage? data, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }
}
