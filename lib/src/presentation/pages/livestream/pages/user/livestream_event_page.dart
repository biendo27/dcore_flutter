part of '../../livestream.dart';

class LivestreamEventPage extends StatelessWidget {
  const LivestreamEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveEventCubit, LiveEventState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.liveEvent,
          isLoading: state.isLoading,
          body: ListView.builder(
            itemCount: state.liveEvent.data.length,
            itemBuilder: (context, index) {
              return LiveEventItem(event: state.liveEvent.data[index]);
            },
          ),
        );
      },
    );
  }
}

