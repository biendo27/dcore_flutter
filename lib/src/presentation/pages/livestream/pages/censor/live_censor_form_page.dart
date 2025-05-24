part of '../../livestream.dart';

class LiveCensorFormPage extends StatefulWidget {
  const LiveCensorFormPage({super.key});

  @override
  State<LiveCensorFormPage> createState() => _LiveCensorFormPageState();
}

class _LiveCensorFormPageState extends State<LiveCensorFormPage> {
  List<List<TextEditingController>> pointControllers = [];
  List<List<TextEditingController>> reviewControllers = [];

  @override
  initState() {
    _initControllers();
    super.initState();
  }

  void _initControllers() {
    LiveCensorState state = context.read<LiveCensorCubit>().state;

    pointControllers = List.generate(
      state.censorForms.length,
      (index) => List.generate(
        state.censorForms[index].data.length,
        (subIndex) => TextEditingController(),
      ),
    );

    reviewControllers = List.generate(
      state.censorForms.length,
      (index) => List.generate(
        state.censorForms[index].data.length,
        (subIndex) => TextEditingController(),
      ),
    );

    if (pointControllers.isNotEmpty && reviewControllers.isNotEmpty) return;

    pointControllers = List.generate(
      state.currentCensorResult.result.length,
      (index) => List.generate(
        state.currentCensorResult.result[index].data.length,
        (subIndex) => TextEditingController(),
      ),
    );

    reviewControllers = List.generate(
      state.currentCensorResult.result.length,
      (index) => List.generate(
        state.currentCensorResult.result[index].data.length,
        (subIndex) => TextEditingController(),
      ),
    );
  }

  Widget censorForm(List<LiveCensorForm> censorForms, List<LiveCensorResultForm> censorResults) {
    if (censorForms.isNotEmpty) {
      return liveCensorBody(censorForms);
    } else {
      return liveCensorResultBody(censorResults);
    }
  }

  Widget liveCensorBody(List<LiveCensorForm> censorForms) {
    return Expanded(
      child: ListView.separated(
        itemCount: censorForms.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        separatorBuilder: (context, index) => 35.verticalSpace,
        itemBuilder: (context, index) {
          LiveCensorResultForm censorResult = censorForms[index].toLiveCensorResultForm;
          if (pointControllers.isEmpty || censorResult.data.isEmpty) return const SizedBox.shrink();

          return LiveCensorFormItem(
            censorResult: censorResult,
            pointControllers: pointControllers[index],
            reviewControllers: reviewControllers[index],
          );
        },
      ),
    );
  }

  Widget liveCensorResultBody(List<LiveCensorResultForm> censorResults) {
    return Expanded(
      child: ListView.separated(
        itemCount: censorResults.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        separatorBuilder: (context, index) => 35.verticalSpace,
        itemBuilder: (context, index) {
          LiveCensorResultForm censorResult = censorResults[index];
          if (pointControllers.isEmpty || censorResult.data.isEmpty) return const SizedBox.shrink();

          return LiveCensorFormItem(
            censorResult: censorResult,
            pointControllers: pointControllers[index],
            reviewControllers: reviewControllers[index],
            readOnly: true,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCensorCubit, LiveCensorState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.contentModeration,
          isLoading: state.isLoading,
          backgroundColor: AppCustomColor.greyF1,
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              censorForm(state.censorForms, state.currentCensorResult.result),
              5.verticalSpace,
              if (state.censorForms.isNotEmpty)
                GradientButton(
                  onPressed: () {
                    List<List<int>> points = pointControllers.map((e) => e.map((e) => int.tryParse(e.text) ?? 0).toList()).toList();
                    List<List<String>> reviews = reviewControllers.map((e) => e.map((e) => e.text).toList()).toList();
                    int liveId = context.read<LiveCubit>().state.currentLive.id;

                    context.read<LiveCensorCubit>().saveLiveCensor(liveId, points, reviews);
                  },
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  text: context.text.send,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              10.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
