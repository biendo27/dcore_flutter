part of '../utils.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAsset.lottie.loading, width: 60.w, height: 60.w));
  }
}
