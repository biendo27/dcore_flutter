part of '../utils.dart';

class DCircleAvatar extends StatelessWidget {
  final String url;
  final double radius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Widget subAction;
  final void Function()? onSubActionTap;
  final void Function()? onTap;

  const DCircleAvatar({
    super.key,
    required this.url,
    required this.radius,
    this.backgroundColor,
    this.border,
    this.subAction = const SizedBox.shrink(),
    this.onSubActionTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmpAvt = InkWell(
      onTap: onTap,
      child: Container(
        width: (radius * 2).w,
        height: (radius * 2).w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border ??
              GradientBoxBorder(
                width: 2.w,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: AppCustomColor.gradientAvatarBorder,
                  stops: const [0.0, 0.23, 0.63, 1],
                ),
              ),
        ),
        child: Container(
          width: (radius * 2 - 2).w,
          height: (radius * 2 - 2).w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(color: AppColorLight.surface, width: 2),
          ),
          child: ClipOval(
            child: _buildImage(),
          ),
        ),
      ),
    );

    if (subAction != const SizedBox.shrink() && onSubActionTap != null) {
      tmpAvt = Stack(
        children: [
          tmpAvt,
          Positioned(
            right: 0,
            bottom: 0,
            child: SubActionItem(icon: subAction, onTap: onSubActionTap),
          ),
        ],
      );
    }
    return tmpAvt;
  }

  Widget _buildImage() {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: _buildProgressIndicator,
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
    }

    if (url.startsWith('/')) {
      return Image.file(
        File(url),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.error),
      );
    }

    return Image.asset(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.error),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, String url, DownloadProgress download) {
    if (download.progress != null) {
      return Center(
        child: Text(
          '${(download.progress! * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10).w,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class SubActionItem extends StatelessWidget {
  final Widget icon;
  final double size;
  final void Function()? onTap;
  const SubActionItem({
    super.key,
    required this.icon,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.w,
        height: size.w,
        alignment: Alignment.center,
        padding: EdgeInsets.all(size * 0.2).w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorLight.surface,
          border: Border.all(color: AppCustomColor.orage4DF5),
        ),
        child: icon,
      ),
    );
  }
}

class NetWorkAvatarRound extends StatelessWidget {
  final ImageProvider avatar;
  final double radius;
  final double borderRadius;

  final Color? backgroundColor;
  const NetWorkAvatarRound({
    super.key,
    required this.avatar,
    required this.radius,
    this.backgroundColor,
    this.borderRadius = 13.2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: const Color(0xfffbf4e4), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffb5b5b5).op(0.25),
            spreadRadius: 0,
            blurRadius: 8.8,
            offset: const Offset(5.5, 5.5), // changes position of shadow
          ),
        ],
        image: DecorationImage(image: avatar, fit: BoxFit.cover),
      ),
    );
  }
}
