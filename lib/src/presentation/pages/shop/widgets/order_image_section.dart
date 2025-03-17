part of '../shop.dart';

class OrderImageSection extends StatelessWidget {
  final List<String> images;

  const OrderImageSection({
    super.key,
    required this.images,
  });

  Future<void> _pickActionImage(BuildContext context) async {
    bool hasPermission = await MediaService.requestMediaPermission();
    if (!hasPermission) return;

    final List<File> pickedImage = await MediaService.pickMultipleImages();
    if (pickedImage.isEmpty) return;
    if (!context.mounted) return;
    List<String> imageUrls = pickedImage.map((e) => e.path).toList();
    context.read<OrderActionCubit>().setActionImages(imageUrls);
  }

  Future<void> _addActionImage(BuildContext context) async {
    final List<File> pickedImage = await MediaService.pickMultipleImages();
    if (pickedImage.isEmpty) return;
    if (!context.mounted) return;
    List<String> imageUrls = pickedImage.map((e) => e.path).toList();
    context.read<OrderActionCubit>().addActionImages(imageUrls);
  }

  void _captureActionImage(BuildContext context) async {
    bool hasPermission = await MediaService.requestMediaPermission();
    if (!hasPermission) return;

    final File? image = await MediaService.captureImage();
    if (image == null) return;
    if (!context.mounted) return;
    context.read<OrderActionCubit>().setActionImages([image.path]);
  }

  @override
  Widget build(BuildContext context) {
    if (images.isNotEmpty) {
      return SingleChildScrollView(
        child: Row(
          children: [
            ...images.map(
              (e) => DCachedImage(
                url: e,
                width: 50.w,
                height: 50.w,
                borderRadius: BorderRadius.circular(10.r),
                margin: EdgeInsets.only(right: 10.w),
                onTap: () => context.read<OrderActionCubit>().removeActionImage(e),
              ),
            ),
            InkWell(
              onTap: () => _addActionImage(context),
              child: Container(
                width: 50.w,
                height: 50.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppCustomColor.greyF5,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.add,
                  color: AppCustomColor.greyE5,
                  size: 30.sp,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        InkWell(
          onTap: () => _pickActionImage(context),
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: AppCustomColor.greyE5,
                size: 30.sp,
              ),
            ),
          ),
        ),
        10.horizontalSpace,
        InkWell(
          onTap: () => _captureActionImage(context),
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                Icons.camera_alt,
                color: AppColorLight.onSurface,
                size: 30.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
