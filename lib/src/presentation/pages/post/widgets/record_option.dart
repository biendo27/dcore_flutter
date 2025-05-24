part of '../post.dart';

class RecordOption extends StatelessWidget {
  const RecordOption({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        if (state.mode != CameraMode.video) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.op(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(context, '10s', Duration(seconds: 10)),
              const SizedBox(width: 16),
              _buildOptionButton(context, '60s', Duration(seconds: 60)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(BuildContext context, String label, Duration duration) {
    return GestureDetector(
      onTap: () => _selectDuration(context, duration),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: context.read<CameraCubit>().state.recordDuration == duration ? AppColorLight.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: AppText(
          label,
          style: AppStyle.text14.copyWith(
            color: AppColorLight.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _selectDuration(BuildContext context, Duration duration) {
    context.read<CameraCubit>().setRecordDuration(duration);
  }
}
