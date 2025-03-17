part of '../../auth.dart';

class SocialBtn extends StatelessWidget {
  final String socialIcon;
  final VoidCallback onPressed;
  const SocialBtn({
    super.key,
    this.socialIcon = '',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5).h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: AppTheme.outline, width: 1.5.w),
        ),
        child: Image.asset(socialIcon, height: 22.w, width: 22.w),
      ),
    );
  }
}
