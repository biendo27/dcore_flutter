part of '../utils.dart';

typedef CountdownCallback = void Function()?;

class CountDownController {
  final ValueNotifier<int> countdownNotifier;
  Timer? _timer;
  final CountdownCallback onStartCount;
  final CountdownCallback onEndCount;
  final int _initialCountdown;
  final bool isFullFormat;
  CountDownController({
    this.isFullFormat = false,
    required int initialCountdown,
    this.onStartCount,
    this.onEndCount,
  })  : countdownNotifier = ValueNotifier<int>(initialCountdown),
        _initialCountdown = initialCountdown;

  void start() {
    if (_timer != null && _timer!.isActive) return; // Prevent multiple timers

    onStartCount?.call(); // Call the onStartCount callback

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (countdownNotifier.value <= 0) {
        timer.cancel();
        onEndCount?.call(); // Call the onEndCount callback
      } else {
        countdownNotifier.value -= 1;
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    stop();
    countdownNotifier.value = _initialCountdown;
    start();
  }

  void dispose() {
    stop();
    countdownNotifier.dispose();
  }

  // Helper method to format the time into dd:hh:mm:ss, hiding leading zeros
  String getFormattedTime(int seconds) {
    if (seconds < 3600) {
      // Less than an hour, format as mm:ss
      int minutes = seconds ~/ 60;
      int secs = seconds % 60;
      return '${!isFullFormat ? '' : '00:'}${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }

    // More than or equal to an hour, use the existing format
    int days = seconds ~/ 86400;
    int hours = (seconds % 86400) ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    List<String> parts = [];
    if (days > 0) parts.add('$days');
    if (days > 0 || hours > 0) parts.add(hours.toString().padLeft(2, '0'));
    parts.add(minutes.toString().padLeft(2, '0'));
    parts.add(secs.toString().padLeft(2, '0'));

    return parts.join(':');
  }
}

class CountdownTimerWidget extends StatelessWidget {
  final TextStyle? style;
  final CountDownController countdownController;

  const CountdownTimerWidget({
    super.key,
    required this.style,
    required this.countdownController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countdownController.countdownNotifier,
      builder: (context, value, child) {
        String formattedTime = countdownController.getFormattedTime(value);
        return AppText(
          formattedTime,
          style: style ?? AppStyle.textBold16,
        );
      },
    );
  }
}
