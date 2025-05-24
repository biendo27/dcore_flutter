part of '../blocs.dart';

@freezed
abstract class AffiliateState with _$AffiliateState {
  const factory AffiliateState({
    @Default(false) bool isLoading,
    @Default(0) int totalOrderSuccess,
    @Default(0) int totalOrder,
    @Default(0) int totalCommission,
    @Default([]) List<AffiliateRequest> listAffiliateRequest,
    @Default([]) List<ProductAffiliate> products,
    @Default([]) List<ProductData> productSaves,
    @Default(Filter()) Filter filter,
    @Default([]) List<TransactionCommissionData> transactionCommissions,
    @Default(0) int coinToMoney,
    @Default(0) int currentPage,
    @Default(AffiliateInfo()) AffiliateInfo affiliateInfo,
    // register
    @Default([]) List<Nation> nations,
    @Default([]) List<City> cities,
    @Default([]) List<District> districts,
    @Default([]) List<Ward> wards,
    Nation? selectedNation,
    City? selectedCity,
    District? selectedDistrict,
    Ward? selectedWard,
  }) = _AffiliateState;

  factory AffiliateState.initial() => AffiliateState();
}
