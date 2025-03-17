part of '../blocs.dart';

@lazySingleton
class CreatePostCubit extends Cubit<CreatePostState> with CubitActionMixin<CreatePostState> {
  final IPostRepository _postRepository;
  final IUploadRepository _uploadRepository;
  final ISoundRepository _soundRepository;
  final IAffiliateRepository _affiliateRepository;

  CreatePostCubit(this._postRepository, this._uploadRepository, this._soundRepository, this._affiliateRepository) : super(CreatePostState.initial());

  void reset() {
    Sound sound = state.selectedSound;
    emit(CreatePostState.initial());
    emit(state.copyWith(selectedSound: sound));
  }

  void init(String videoPath) {
    reset();
    emit(state.copyWith(videoPath: videoPath));
  }

  void updateTitle(String title) => emit(state.copyWith(title: title));
  void updateDescription(String description) => emit(state.copyWith(description: description));
  void toggleAllowComments() => emit(state.copyWith(allowComments: !state.allowComments));
  void toggleAllowDownload() => emit(state.copyWith(allowDownload: !state.allowDownload));
  void updateSelectedLanguage(LocaleType language) => emit(state.copyWith(selectedLanguage: language));
  void updateSelectedSound(Sound sound) => emit(state.copyWith(selectedSound: sound));
  void setThumbnail(String thumbnailPath) => emit(state.copyWith(thumbnailPath: thumbnailPath));
  void updateHashtags(List<HashTag> hashtags) => emit(state.copyWith(hashtags: hashtags));
  void setOnVideoReady(void Function(String videoPath) onVideoReady) => emit(state.copyWith(onVideoReady: onVideoReady));
  void selectProduct(Product? product) => emit(state.copyWith(selectedProduct: product));

  void generateThumbnail() async {
    String thumbnailPath = await MediaService.getVideoThumbnailPath(state.videoPath);
    emit(state.copyWith(thumbnailPath: thumbnailPath));
  }


  void addHashtag(HashTag hashtag) {
    if (state.hashtags.contains(hashtag)) return;
    List<HashTag> newHashtags = [...state.hashtags, hashtag];
    emit(state.copyWith(hashtags: newHashtags));
  }

  Future<String> _uploadThumbnail() async {
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(state.thumbnailPath)],
    );
    if (response.data.isNotEmpty == true) {
      return response.data.first.url;
    }
    return '';
  }

  Future<String> _uploadVideo() async {
    String videoPath = '';

    if (state.mergedVideoPath.isNotEmpty && state.selectedSound.id != 0) {
      videoPath = state.mergedVideoPath;
    } else {
      videoPath = state.videoPath;
    }

    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.postVideo,
      [File(videoPath)],
    );
    if (response.data.isNotEmpty == true) {
      return response.data.first.url;
    }
    return '';
  }

  Future<String> _uploadAudio(File audioFile) async {
    final BaseResponseList<AppFile> response = await _uploadRepository.uploadFile(
      UploadType.soundAudio,
      [audioFile],
    );
    if (response.data.isNotEmpty == true) {
      return response.data.first.url;
    }
    return '';
  }

  void mixAudioToVideo() async {
    emit(state.copyWith(isLoading: true));
    if (state.selectedSound.id == 0) {
      state.onVideoReady?.call(state.videoPath);
      emit(state.copyWith(isLoading: false));
      return;
    }

    String outputPath = await MediaService.mixAudioToVideo(
      localVideoPath: state.videoPath,
      remoteAudioUrl: state.selectedSound.audio,
    );

    emit(state.copyWith(mergedVideoPath: outputPath));
    state.onVideoReady?.call(outputPath);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> setAudio() async {
    if (state.selectedSound.id != 0) return;
    if (state.videoPath.isEmpty) return;
    File? audioFile = await MediaService.getAudioFromVideoPath(state.videoPath);
    if (audioFile == null) return;
    String audioUrl = await _uploadAudio(audioFile);
    executeAction(
      action: () async => _soundRepository.createSound({'audio': audioUrl}),
      onSuccess: (response) => emit(state.copyWith(selectedSound: response.data!)),
    );
  }

  Future<void> createPost() async {
    emit(state.copyWith(isLoading: true));
    bool enabledContentModeration = AppConfig.context!.read<ConfigCubit>().state.contact.contentModerationSetting.status;
    bool isVideoSafe = true;
    
    if (enabledContentModeration) {
      isVideoSafe = await AppConfig.context!.read<ModerationCubit>().checkVideo(File(state.videoPath));
    }

    if (!isVideoSafe) {
      DMessage.showMessage(message: AppConfig.context!.text.videoContentModerationError, type: MessageType.error);
      emit(state.copyWith(isLoading: false));
      return;
    }

    String thumbnailUrl = '';
    if (state.thumbnailPath.isNotEmpty) {
      thumbnailUrl = await _uploadThumbnail();
    }

    if (thumbnailUrl.isEmpty) {
      thumbnailUrl = 'post_thumbnails/post_thumbnail_6715b9ab8aa8b.jpg';
    }

    final String videoUrl = await _uploadVideo();
    int soundId = state.selectedSound.id == 0 ? 1 : state.selectedSound.id;
    int productId = state.selectedProduct?.id ?? 0;
    List<int> hashtagIds = state.hashtags.map((e) => e.id).toList();
    hashtagIds = hashtagIds.toSet().toList();
    PostParam param = PostParam(
      soundId: soundId,
      description: state.description,
      hashTags: hashtagIds,
      video: videoUrl,
      thumbnail: thumbnailUrl,
      canComment: state.allowComments,
      canSave: state.allowDownload,
      language: state.selectedLanguage.value,
      productId: productId,
      privacy: 'public',
    );

    Map<String, dynamic> paramJson = param.toJson();

    if (productId == 0) {
      paramJson.remove('product_id');
    }

    await executeAction<Post>(
      action: () async => _postRepository.createPost(paramJson),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        emit(state.copyWith(isLoading: false));
        DMessage.showMessage(message: response.message, type: MessageType.success);
        DNavigator.newRoutesNamed(RouteNamed.home);
        emit(CreatePostState.initial());
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  void getAffiliateProducts() {
    executeListAction(
      action: () async => _affiliateRepository.affiliateProduct(),
      onSuccess: (response) => emit(state.copyWith(products: response.data)),
    );
  }
}
