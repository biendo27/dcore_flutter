part of '../setting.dart';

class NotRegisterAffiliateBody extends StatelessWidget {
  const NotRegisterAffiliateBody({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          20.verticalSpace,
          Expanded(
            child: BlocBuilder<AffiliateCubit,AffiliateState>(
              builder: (context, state) {
                if(state.listAffiliateRequest.isEmpty) {
                  return emptyData(context);
                }
                final data = state.listAffiliateRequest;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AffiliateItem(
                      title: data[index].name,
                      status: data[index].status,
                      date: data[index].createdAtFormat,
                      success: data[index].status.contains("Thành công"),
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyData(BuildContext context) {
    return Center(
      child: Column(
        children: [
          60.verticalSpace,
          Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
          AppText(context.text.emptyList, style: AppStyle.textBold14),
        ],
      ),
    );
  }
}
