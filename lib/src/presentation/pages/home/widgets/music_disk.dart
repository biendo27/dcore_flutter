part of '../home.dart';

class MusicDisk extends StatelessWidget {
  final Post post;
  const MusicDisk({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<VideoCubit>().checkAuthAndNavigate();
        if (AppGlobalValue.accessToken.isEmpty) return;
        context.read<SoundCubit>()
          ..setCurrentSound(post.sound)
          ..fetchSoundDetail(post.sound.id);
        DNavigator.goNamed(RouteNamed.videoAudio);
      },
      child: DCachedImage(
        height: 40.w,
        width: 40.w,
        url: post.sound.image,
        borderRadius: BorderRadius.circular(100.r),
      ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: 5.seconds),
    );
  }
}
