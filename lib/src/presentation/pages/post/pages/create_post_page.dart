part of '../post.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController hashtagController = TextEditingController();
  Timer _debounce = Timer(Duration.zero, () {});

  String get lastTypedHashtag {
    final text = hashtagController.text;
    final lastHashtagMatch = RegExp(r'#[\w\u0080-\u9999]*$').allMatches(text).last;
    return lastHashtagMatch.group(0)?.replaceFirst('#', '') ?? '';
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    context.read<CreatePostCubit>()
      ..getAffiliateProducts()
      ..setAudio();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.createPost,
      isLoading: context.select((CreatePostCubit cubit) => cubit.state.isLoading),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThumbnailSection(descriptionController: descriptionController),
              16.verticalSpace,
              BlocListener<CreatePostCubit, CreatePostState>(
                listener: (context, state) {
                  // Update last hashtag if use choose hashtag result different from last hashtag typed
                  if (state.hashtags.isNotEmpty && lastTypedHashtag != state.hashtags.last.name) {
                    String newHashtag = state.hashtags.last.name;
                    hashtagController.text = hashtagController.text.replaceFirst(lastTypedHashtag, newHashtag);
                  }
                },
                child: DTextField(
                  controller: hashtagController,
                  hint: '#hashtag',
                  onChanged: _handleHashtagChange,
                ),
              ),
              16.verticalSpace,
              BlocBuilder<HashtagCubit, HashtagState>(
                builder: (context, state) {
                  if (state.hashtags.data.isEmpty) return CreatePostOptionBody();
                  return ListHashtagOption(hashtags: state.hashtags.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleHashtagChange(String value) {
    _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Get the cursor position
      final cursorPos = hashtagController.selection.baseOffset;
      final text = value.substring(0, cursorPos);

      // Find the last hashtag being typed
      final lastHashtagMatch = RegExp(r'#[\w\u0080-\u9999]*$').firstMatch(text);

      if (lastHashtagMatch != null) {
        final searchTerm = lastHashtagMatch.group(0)?.replaceFirst('#', '');
        if (searchTerm != null && searchTerm.isNotEmpty) {
          context.read<HashtagCubit>().fetchHashtagList(search: searchTerm);
        }
        return;
      }
      context.read<HashtagCubit>().reset();
    });
  }
}
