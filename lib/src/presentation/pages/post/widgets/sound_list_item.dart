part of '../post.dart';

class SoundListItem extends StatefulWidget {
  final Sound sound;
  final bool isFavorite;
  const SoundListItem({
    super.key,
    required this.sound,
    this.isFavorite = false,
  });

  @override
  State<SoundListItem> createState() => _SoundListItemState();
}

class _SoundListItemState extends State<SoundListItem> {
  AudioPlayer audioPlayer = AudioPlayer();
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);
  ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    CreatePostState state = context.read<CreatePostCubit>().state;
    if (state.selectedSound.id != 0 && state.videoPath.isNotEmpty) return;

    await audioPlayer.setLoopMode(LoopMode.one);

    // Listen to audio states
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // No need to handle completion since it will auto-loop
        // But you might want to update UI or state here
        positionNotifier.value = Duration.zero;
      }
    });

    // Listen to duration changes
    audioPlayer.durationStream.listen((newDuration) {
      durationNotifier.value = newDuration ?? Duration.zero;
    });

    // Listen to position changes
    audioPlayer.positionStream.listen((newPosition) {
      positionNotifier.value = newPosition;
    });

    // Set initial audio source
    try {
      await audioPlayer.setUrl(widget.sound.audio);
    } catch (e) {
      LogDev.error('Error loading audio: $e');
    }
  }

  void _handleStateChange(CreatePostState state) {
    final isSelected = state.selectedSound.id == widget.sound.id;

    if (isSelected && !isPlayingNotifier.value) {
      audioPlayer.play();
      isPlayingNotifier.value = true;
      return;
    }

    if (!isSelected && isPlayingNotifier.value) {
      audioPlayer.pause();
      audioPlayer.seek(Duration.zero); // Reset position when stopped
      isPlayingNotifier.value = false;
    }
  }

  Widget get trailing {
    if (widget.isFavorite) {
      return SvgPicture.asset(
        AppAsset.svg.bookmarked,
        width: 20.w,
        height: 20.h,
        colorFilter: const ColorFilter.mode(AppColorLight.onSurface, BlendMode.srcIn),
      );
    }

    return SvgPicture.asset(
      AppAsset.svg.scissors,
      width: 20.w,
      height: 20.h,
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Widget get _playPauseButton {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        final isSelected = state.selectedSound.id == widget.sound.id;
        if (state.isLoading && isSelected) return const CircularProgressIndicator();
        return Icon(
          isSelected ? Icons.pause_circle_filled : Icons.play_circle_fill,
          size: 20.sp,
          color: AppColorLight.surface,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listenWhen: (previous, current) => previous.selectedSound.id != current.selectedSound.id,
      listener: (context, state) => _handleStateChange(state),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 8.w,
        horizontalTitleGap: 8.w,
        dense: true,
        onTap: () {
          final isSelected = context.read<CreatePostCubit>().state.selectedSound.id == widget.sound.id;
          if (isSelected) {
            context.read<CreatePostCubit>().updateSelectedSound(Sound());
            return;
          }

          context.read<CreatePostCubit>()
            ..updateSelectedSound(widget.sound)
            ..mixAudioToVideo();
        },
        leading: Stack(
          alignment: Alignment.center,
          children: [
            DCachedImage(
              url: widget.sound.image,
              width: 50.w,
              height: 50.h,
              borderRadius: BorderRadius.circular(10.r),
            ),
            _playPauseButton,
          ],
        ),
        title: BlocBuilder<CreatePostCubit, CreatePostState>(
          builder: (context, state) {
            final isSelected = state.selectedSound.id == widget.sound.id;
            return Row(
              children: [
                if (isSelected) ...[
                  Image.asset(AppAsset.gif.wave.path, width: 25.w, height: 25.h),
                  5.horizontalSpace,
                ],
                Expanded(
                  child: AppText(
                    widget.sound.displayTitle(context),
                    textAlign: TextAlign.left,
                    style: AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            );
          },
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${widget.sound.singer} • ${context.text.usedVideo(widget.sound.posts.length)} • ${widget.sound.duration.formatTime}',
              style: AppStyle.text12.copyWith(color: AppColorLight.onSurface.op(0.25)),
            ),
            BlocBuilder<CreatePostCubit, CreatePostState>(
              builder: (context, state) {
                final isSelected = state.selectedSound.id == widget.sound.id;
                if (isSelected) {
                  return Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: ValueListenableBuilder(
                      valueListenable: durationNotifier,
                      builder: (context, duration, child) {
                        return LinearProgressIndicator(
                          value: duration.inSeconds > 0 ? positionNotifier.value.inSeconds / duration.inSeconds : 0,
                          backgroundColor: AppColorLight.onSurface.op(0.25),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColorLight.primary),
                          minHeight: 2,
                        );
                      }
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        trailing: trailing,
      ),
    );
  }
}
