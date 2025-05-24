part of '../message.dart';

class TopBarArea extends StatelessWidget {
  final Function() onTapAdd;
  final Conversation? conversation;

  const TopBarArea({super.key, required this.onTapAdd, this.conversation});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              String image = (conversation?.user?.image ?? "").contains("https") ? conversation!.user!.image! : ConstRes.itemBaseUrl + (conversation?.user?.image ?? '');
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
                                  conversation?.user?.userFullName ?? 'aaa',
                                  style: AppStyle.text16.copyWith(overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                              ),
                              5.horizontalSpace,
                              Flexible(
                                child: Visibility(
                                  visible: conversation?.user?.isVerified ?? false,
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
                              AppText(context.text.activity, style: AppStyle.text12.copyWith(overflow: TextOverflow.ellipsis), maxLines: 1),
                              4.horizontalSpace,
                              Container(
                                height: 8.sp,
                                width: 8.sp,
                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
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
            10.horizontalSpace,
            GestureDetector(
              onTap: onTapAdd,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.linear_scale),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
