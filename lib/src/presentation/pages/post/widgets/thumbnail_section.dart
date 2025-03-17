part of '../post.dart';

class ThumbnailSection extends StatelessWidget {
  final TextEditingController descriptionController;
  const ThumbnailSection({
    super.key,
    required this.descriptionController,
  });

  String _thumbnail(String thumbnailPath) {
    if (thumbnailPath.isEmpty) {
      return AppAsset.images.mainIcon.path;
    }
    return thumbnailPath;
  }

  Future<void> _pickThumbnail() async {
    bool hasPermission = await MediaService.requestMediaPermission();
    if (!hasPermission) return;

    final pickedImage = await MediaService.pickImage();
    if (pickedImage == null) return;
    AppConfig.context?.read<CreatePostCubit>().setThumbnail(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<CreatePostCubit, CreatePostState>(
              builder: (context, state) {
                return VideoPreview(
                  videoPath: state.videoPath,
                  thumbnailPath: _thumbnail(state.thumbnailPath),
                  width: 85.w,
                  height: 125.h,
                  borderRadius: BorderRadius.circular(8.r),
                );
              },
            ),
            8.horizontalSpace,
            DTextField(
              expandFlex: 1,
              controller: descriptionController,
              hint: context.text.videoDescription,
              onChanged: (value) => context.read<CreatePostCubit>().updateDescription(value),
              type: DTextInputType.multiline,
              margin: EdgeInsets.zero,
              maxLines: 6,
              contentPadding: EdgeInsets.zero,
              inputStyle: AppStyle.text14,
              hintStyle: AppStyle.text14.copyWith(color: AppColorLight.outlineVariant),
              fillColor: AppColorLight.surface,
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ],
        ),
        16.verticalSpace,
        GestureDetector(
          onTap: _pickThumbnail,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, color: Colors.grey[600]),
                const SizedBox(width: 8),
                AppText(context.text.selectThumbnail, style: AppStyle.text14.copyWith(color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
