part of '../models.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @Default(0) int id,
    @Default(0) int roleId,
    @Default(UserRole.user) UserRole roleCode,
    @Default('') String accessToken,
    @Default('') String name,
    @Default('') String username,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String image,
    @Default('') String bio,
    @Default('') String facebookUrl,
    @Default('') String youtubeUrl,
    @Default('') String instagramUrl,
    @Default('') String language,
    @Default('') String timezone,
    @Default(null) DateTime? birthday,
    @Default(0) int totalLikes,
    @Default(0) int totalFollowing,
    @Default(0) int totalFollower,
    @Default(0) int wallet,
    @Default(false) bool isAffiliate,
    @Default(false) bool isFollowedByUser,
    @Default(false) bool isFollowedMe,
    @Default(0) int totalGiftCoin,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(null) DateTime? deletedAt,
    @Default(null) DateTime? liveEventStartAt,
    @Default(null) DateTime? liveEventEndAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}

enum UserRole {
  @JsonValue('user')
  user,
  @JsonValue('employee')
  employee,
  @JsonValue('admin')
  admin,
  @JsonValue('streamer')
  streamer,
  @JsonValue('digital')
  digital,
  @JsonValue('store')
  store,
  @JsonValue('censor')
  censor,
}

enum UserType {
  @JsonValue('suggested')
  suggested,
  @JsonValue('follower')
  follower,
  @JsonValue('following')
  following,
  @JsonValue('friend')
  friend;

  String get displayName {
    return switch (this) {
      UserType.suggested => AppConfig.context!.text.suggested,
      UserType.follower => AppConfig.context!.text.follower,
      UserType.following => AppConfig.context!.text.following,
      UserType.friend => AppConfig.context!.text.friend,
    };
  }
}

extension AppUserExtension on AppUser {
  String get displayName => name.isEmpty ? username : name;

  String get avatarUrl => image.startsWith('http') ? image : AppAsset.images.logo.path;

  String get birthdayDisplay {
    if (birthday == null) return AppConfig.context!.text.na;
    if (birthday!.millisecondsSinceEpoch <= 0) return AppConfig.context!.text.na;
    return birthday!.toLocalDateString;
  }

  String get emailDisplay => email.isEmpty ? AppConfig.context!.text.na : email;

  bool get isHost => roleCode != UserRole.user;

  bool isHostCurrentLive(int hostId) => id == hostId && roleCode == UserRole.employee;

  bool get isCensor => roleCode == UserRole.censor;

  Widget avatarWidget({
    double width = 40,
    double height = 40,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    return DCachedImage(
      url: avatarUrl,
      width: width.w,
      height: height.w,
      borderRadius: borderRadius ?? BorderRadius.circular(width / 2),
      fit: BoxFit.cover,
      onTap: onTap,
    );
  }

  Widget avatarWidgetAction({
    double width = 40,
    double height = 40,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    return DCachedImage(
      url: avatarUrl,
      width: width.w,
      height: height.w,
      borderRadius: borderRadius ?? BorderRadius.circular(width / 2),
      fit: BoxFit.cover,
      onTap: onTap ??
          () {
            if (id == AppConfig.context!.read<UserCubit>().state.user.id) return;
            AppConfig.context!.read<ProfilePreviewCubit>()
              ..reset()
              ..setCurrentUser(this);
            DNavigator.goNamed(RouteNamed.profilePreview);
          },
    );
  }
}
