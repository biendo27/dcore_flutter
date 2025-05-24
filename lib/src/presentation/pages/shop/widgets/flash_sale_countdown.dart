part of '../shop.dart';

class FlashSaleCountdown extends StatefulWidget {
  const FlashSaleCountdown({
    super.key,
    required this.initialDuration,
  });
  final Duration initialDuration;
  @override
  State<FlashSaleCountdown> createState() => _FlashSaleCountdownState();
}

class _FlashSaleCountdownState extends State<FlashSaleCountdown> {
  late Duration remainingTime;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.initialDuration;
    startTimer();
  }

  void startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String hours = remainingTime.inHours.toString().padLeft(2, '0');
    final String minutes = (remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      children: [
        _buildTimeBox(hours),
        AppText(' : ', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
        _buildTimeBox(minutes),
        AppText(' : ', style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
        _buildTimeBox(seconds),
      ],
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      // padding: EdgeInsets.all(8.sp),
      width: 26.w,
      height: 26.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppCustomColor.orangeF1,
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: AppText(
        time,
        style: AppStyle.text12.copyWith(color: AppColorLight.surface),
      ),
    );
  }
}
