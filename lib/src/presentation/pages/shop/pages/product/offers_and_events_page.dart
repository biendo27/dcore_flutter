part of '../../shop.dart';

class OffersAndEventsPage extends StatelessWidget {
  const OffersAndEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.offersAndEvents,
          isLoading: state.isLoading,
          onRefresh: () async => context.read<EventCubit>().getEvents(isInit: true),
          onLoadMore: () => context.read<EventCubit>().getEvents(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.events.data.length,
                    itemBuilder: (context, index) {
                      return OffersAndEventsProductItem(
                        event: state.events.data[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
