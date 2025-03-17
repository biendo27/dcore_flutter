part of '../message.dart';

class ImagePreview extends StatelessWidget {
  final ChatMessage? message;

  const ImagePreview({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(
                '${ConstRes.itemBaseUrl}${message?.image}',
              ),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
            topBarArea(context)
          ],
        ),
      ),
    );
  }

  Widget topBarArea(BuildContext context) {
    final userId = context.read<UserCubit>().state.user.id;
    return Container(
      color: Colors.black.op(0.3),
      padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26.sp),
          ),
          20.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'username',
                child: AppText(
                  message?.senderUser?.userid == userId ? 'You' : '${message?.senderUser?.userFullName} ',
                  style: AppStyle.text16.copyWith(color: Colors.white),
                ),
              ),
              AppText(
                DateFormat(
                  '${"dd MMM yyyy"}, ${"hh:mm a"}',
                ).format(DateTime.fromMillisecondsSinceEpoch(message!.time!.toInt())),
                style: AppStyle.text12.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
