part of '../home.dart';

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const ActionIcon({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 20.sp),
          AppText(label, style: AppStyle.text10),
        ],
      ),
    );
  }
}
