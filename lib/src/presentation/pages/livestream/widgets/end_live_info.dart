part of '../livestream.dart';

class EndLiveInfo extends StatelessWidget {
  final int info;
  final String title;

  const EndLiveInfo({
    super.key,
    this.info = 0,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('$info', style: AppStyle.textBold14),
          AppText(title, style: AppStyle.text12),
        ],
      ),
    );
  }
}
