part of '../../shop.dart';

class OffersAndEventsDetailPage extends StatefulWidget {
  const OffersAndEventsDetailPage({super.key});

  @override
  State<OffersAndEventsDetailPage> createState() => _OffersAndEventsDetailPageState();
}

class _OffersAndEventsDetailPageState extends State<OffersAndEventsDetailPage> {
  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return SubLayout(
          title: state.currentEvent.name,
          isLoading: state.isLoading,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: DCachedImage(
                    borderRadius: BorderRadius.circular(10.r),
                    url: state.currentEvent.image,
                    height: 225.h,
                  ),
                ),
                10.verticalSpace,
                AppText(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  state.currentEvent.name,
                  style: AppStyle.text20.copyWith(fontWeight: FontWeight.w600),
                ),
                5.verticalSpace,
                AppText(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  state.currentEvent.description,
                  style: AppStyle.text16.copyWith(fontWeight: FontWeight.w300),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                12.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppCustomColor.orangeFE.op(0.1),
                    border: Border.symmetric(horizontal: BorderSide(color: AppCustomColor.greyE9)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DHighlightText(
                        text: "${context.text.voucherCode} : ${state.currentEvent.voucher.code}",
                        highlights: [state.currentEvent.voucher.code],
                        highlightStyles: [
                          AppStyle.text14.copyWith(color: AppCustomColor.orangeFE),
                        ],
                      ),
                      ButtonSave(
                        onTap: () {
                          setState(() {
                            isSave = !isSave;
                          });
                        },
                        isSave: isSave,
                      )
                    ],
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: DHighlightText(
                    text: "${context.text.expirationDate}: ${context.text.to} ${state.currentEvent.endTime?.dateValueString ?? ''}",
                    highlights: ["${context.text.to} ${state.currentEvent.endTime?.dateValueString ?? ''}"],
                    style: AppStyle.text14.copyWith(color: AppCustomColor.greyAC),
                    highlightStyles: [
                      AppStyle.text14.copyWith(color: AppCustomColor.blue17),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: AppText(
                    state.currentEvent.content,
                    style: AppStyle.text16.copyWith(fontWeight: FontWeight.w300),
                    maxLines: 1000,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
