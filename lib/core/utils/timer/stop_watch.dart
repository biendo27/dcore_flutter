part of '../utils.dart';

typedef StopwatchCallback = void Function(int elapsedSeconds);

class StopWatchController {
  final ValueNotifier<int> stopwatchNotifier;
  Timer? _timer;
  final StopwatchCallback? onStartCount;
  final StopwatchCallback? onStopCount;

  StopWatchController({
    this.onStartCount,
    this.onStopCount,
  }) : stopwatchNotifier = ValueNotifier<int>(0);

  void startTimer() {
    if (_timer != null && _timer!.isActive) return; // Prevent multiple timers

    onStartCount?.call(stopwatchNotifier.value); // Call the onStartCount callback

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      stopwatchNotifier.value += 1; // Increment the stopwatch every second
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    onStopCount?.call(stopwatchNotifier.value); // Call the onStopCount callback
  }

  void resetTimer() {
    stopTimer();
    stopwatchNotifier.value = 0; // Reset the stopwatch to 0
    startTimer(); // Restart the timer
  }

  void dispose() {
    stopTimer();
    stopwatchNotifier.dispose();
  }

  // Helper method to format the time into dd:hh:mm:ss, hiding leading zeros
  String getFormattedTime(int seconds) {
    if (seconds < 3600) {
      // Less than an hour, format as mm:ss
      int minutes = seconds ~/ 60;
      int secs = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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

class StopwatchWidget extends StatelessWidget {
  final TextStyle? style;
  final StopWatchController stopwatchController;

  const StopwatchWidget({
    super.key,
    this.style,
    required this.stopwatchController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: stopwatchController.stopwatchNotifier,
      builder: (context, value, child) {
        String formattedTime = stopwatchController.getFormattedTime(value);
        return AppText(
          formattedTime,
          style: style ?? AppStyle.textBold16,
        );
      },
    );
  }
}
