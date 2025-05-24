part of '../post.dart';

class ListHashtagOption extends StatelessWidget {
  final List<HashTag> hashtags;
  const ListHashtagOption({super.key, required this.hashtags});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColorLight.outlineVariant)),
      ),
      child: Column(
        children: hashtags
            .map((e) => ListTile(
                  onTap: () {
                    context.read<CreatePostCubit>().addHashtag(e);
                    context.read<HashtagCubit>().reset();
                  },
                  dense: true,
                  title: AppText('#${e.name}', style: AppStyle.textBold16),
                ))
            .toList(),
      ),
    );
  }
}
