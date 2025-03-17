part of '../utils.dart';

class ExpandContainer extends StatefulWidget {
  final Widget header;
  final Widget body;
  const ExpandContainer({super.key, required this.header, required this.body});

  @override
  State<ExpandContainer> createState() => _ExpandContainerState();
}

class _ExpandContainerState extends State<ExpandContainer> with SingleTickerProviderStateMixin {
  bool opened = false;
  late Animation<double> animation = Tween<double>(begin: 0, end: 200).animate(controller)
    ..addListener(() {
      setState(() {});
    });
  late AnimationController controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: opened
                ? () {
                    debugPrint("CLOSING");
                    controller.reverse();
                    opened = false;
                  }
                : () {
                    debugPrint("OPENING");
                    controller.forward();
                    opened = true;
                  },
            child: widget.header),
        Container(
          constraints: BoxConstraints(maxHeight: animation.value),
          child: widget.body,
        )
      ],
    );
  }
}
