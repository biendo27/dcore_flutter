part of '../message.dart';

class BottomBar extends StatelessWidget {
  final TextEditingController msgController;
  final VoidCallback onShareBtnTap;
  final VoidCallback onCameraTap;
  final bool isBlocked;
  final bool isBlockFromOther;

  const BottomBar({super.key, required this.msgController, required this.onShareBtnTap, required this.onCameraTap, required this.isBlocked,  required this.isBlockFromOther});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: _widgetAnimated(child: isBlockFromOther
          ? _viewBlocked()
          : _viewInputMessage(context)),
    );
  }

  Widget _viewBlocked() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.symmetric(vertical: 9),
      child: AppText(!isBlocked ? "Bạn đã bị chặn, hiện không thể gửi tin nhắn!" : "Bạn đã chặn người dùng này", style: AppStyle.text14),
    );
  }

  Widget _viewInputMessage(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
          if (state.replying.isEmpty) {
            return SizedBox();
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            decoration: BoxDecoration(
                color: Colors.white.op(0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  topRight: Radius.circular(15.sp),
                )),
            child: Row(
              children: [
                Expanded(
                    child: AppText(
                  state.replying,
                  style: AppStyle.text14.copyWith(color: Colors.grey.op(0.8)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                10.horizontalSpace,
                IconButton(
                    onPressed: context.read<MessageCubit>().onCloseMessage,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ))
              ],
            ),
          );
        }),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Color(0xffF2F2F2)),
                  child: TextFormField(
                    controller: msgController,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: GestureDetector(
                        onTap: () => onCameraTap(),
                        child: Container(
                          height: 30.sp,
                          width: 30.sp,
                          margin: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.sp), color: AppCustomColor.orangeF1),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () => onShareBtnTap(),
                          child: Icon(
                            Icons.send,
                            size: 20.sp,
                          )),
                      contentPadding: EdgeInsets.only(left: 15, top: 12.sp),
                      border: InputBorder.none,
                      hintText: "Nhắn tin...",
                      hintStyle: AppStyle.text14.copyWith(color: Colors.grey),
                    ),
                    style: AppStyle.text14,
                    cursorColor: Colors.grey,
                    cursorHeight: 17.sp,
                    cursorRadius: Radius.circular(5.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AnimatedSwitcher _widgetAnimated({required Widget child}) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: const Offset(0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child);
        },
        child: child);
  }
}
