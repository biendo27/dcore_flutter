part of '../blocs.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    @Default(false) bool isLoading,
    @Default([]) List<Product> products,
    @Default(Product()) Product currentProduct,
    @Default(ProductDetail()) ProductDetail currentProductDetail,
    @Default(ProductService()) ProductService productService,
    @Default([]) List<Voucher> vouchers,
    @Default('') String productCancelOrderTutorialTerm,
  }) = _ProductState;

  factory ProductState.initial() => const ProductState();
}

extension ProductStateX on ProductState {
  List<ProductReview> get takeTwoReviews => currentProductDetail.reviews.take(2).toList();

  bool get hasReview => currentProductDetail.reviews.isNotEmpty;

  bool get hasPost => currentProductDetail.posts.isNotEmpty;
}
