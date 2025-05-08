part of '../models.dart';

@freezed
abstract class CommissionRepository with _$CommissionRepository {
  const factory CommissionRepository({
    @Default(0) int totalCommission,
    @Default(TransactionCommission()) TransactionCommission transactions,
  }) = _CommissionRepository;

  factory CommissionRepository.fromJson(Map<String, dynamic> json) => _$CommissionRepositoryFromJson(json);
}

@freezed
abstract class TransactionCommission with _$TransactionCommission {
  const factory TransactionCommission({
    @Default(0) int currentPage,
    @Default([]) List<TransactionCommissionData> data,
  }) = _TransactionCommission;

  factory TransactionCommission.fromJson(Map<String, dynamic> json) => _$TransactionCommissionFromJson(json);
}

@freezed
abstract class TransactionCommissionData with _$TransactionCommissionData {
  const factory TransactionCommissionData({
    @Default(0) int id,
    @Default(TransactionCommissionDataProduct()) TransactionCommissionDataProduct product,
    @Default("") String affiliateType,
    @Default(0) int commission,
    @Default("") String affiliateValue,
    @Default("") String code,
    @Default("") String commissionValue,
    @Default("") String createdAtFormat,
    @Default("") String status,
  }) = _TransactionCommissionData;

  factory TransactionCommissionData.fromJson(Map<String, dynamic> json) => _$TransactionCommissionDataFromJson(json);
}

@freezed
abstract class TransactionCommissionDataProduct with _$TransactionCommissionDataProduct {
  const factory TransactionCommissionDataProduct({
    @Default(0) int id,
    @Default(ProductAffiliate()) ProductAffiliate product,
    @Default(0) int quantity,
    @Default(0) int totalMoney,
    @Default(false) bool reviewed,
    @Default(0) int price,
    @Default([]) List<AttributeValue> variant,
  }) = _TransactionCommissionDataProduct;

  factory TransactionCommissionDataProduct.fromJson(Map<String, dynamic> json) => _$TransactionCommissionDataProductFromJson(json);
}
