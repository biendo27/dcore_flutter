part of '../blocs.dart';

@freezed
abstract class DeliveryAddressState with _$DeliveryAddressState {
  const factory DeliveryAddressState({
    @Default(false) bool isLoading,
    @Default([]) List<UserBillingAddress> addresses,
    @Default(UserBillingAddress()) UserBillingAddress currentAddress,
    @Default([]) List<Nation> nations,
    @Default([]) List<City> cities,
    @Default([]) List<District> districts,
    @Default([]) List<Ward> wards,
    Nation? selectedNation,
    City? selectedCity,
    District? selectedDistrict,
    Ward? selectedWard,
  }) = _DeliveryAddressState;

  factory DeliveryAddressState.initial() => const DeliveryAddressState();
}

extension DeliveryAddressStateExtension on DeliveryAddressState {
  bool get hasSelectedNation => selectedNation != null;
  bool get hasSelectedCity => selectedCity != null;
  bool get hasSelectedDistrict => selectedDistrict != null;
  bool get hasSelectedWard => selectedWard != null;

  bool get isValidLocation => hasSelectedNation && hasSelectedCity && hasSelectedDistrict && hasSelectedWard;

  String get nationText => selectedNation?.name ?? '';
  String get cityText => selectedCity?.name ?? '';
  String get districtText => selectedDistrict?.name ?? '';
  String get wardText => selectedWard?.name ?? '';

  String get fullAddressText {
    if (!isValidLocation) return '';
    return [wardText, districtText, cityText, nationText].where((text) => text.isNotEmpty).join(', ');
  }

  UserBillingAddress get defaultAddress => addresses.firstWhere((address) => address.isDefault, orElse: () => UserBillingAddress());
}
