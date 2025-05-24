part of 'routes.dart';

//* Splash Page
@TypedGoRoute<SplashRoute>(path: RoutePath.splash, name: RouteNamed.splash)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

//* Intro Page
@TypedGoRoute<IntroRoute>(path: RoutePath.intro, name: RouteNamed.intro)
class IntroRoute extends GoRouteData {
  const IntroRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const IntroPage();
}

//* No Auth Page
@TypedGoRoute<NoAuthRoute>(path: RoutePath.noAuth, name: RouteNamed.noAuth)
class NoAuthRoute extends GoRouteData {
  const NoAuthRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const NoAuthPage();
}

//* Auth Pages
@TypedGoRoute<LoginRoute>(
  path: RoutePath.login,
  name: RouteNamed.login,
  routes: [
    TypedGoRoute<ForgotPasswordRoute>(path: RoutePath.forgotPassword, name: RouteNamed.forgotPassword),
    TypedGoRoute<OtpRoute>(path: RoutePath.otp, name: RouteNamed.otp),
    TypedGoRoute<SetupPasswordRoute>(path: RoutePath.setupPassword, name: RouteNamed.setupPassword),
    TypedGoRoute<ChangePasswordRoute>(path: RoutePath.changePassword, name: RouteNamed.changePassword),
  ],
)
class LoginRoute extends BaseTransitionRouteData {
  const LoginRoute();

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) => const LoginPage();
}

class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ForgotPassPage();
}

class OtpRoute extends GoRouteData {
  const OtpRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const OtpPage();
}

class SetupPasswordRoute extends GoRouteData {
  const SetupPasswordRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SetupPassPage();
}

class ChangePasswordRoute extends GoRouteData {
  const ChangePasswordRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ChangePasswordPage();
}

@TypedGoRoute<RegisterRoute>(path: RoutePath.register, name: RouteNamed.register)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const RegisterPage();
}

//* Shell Routes
@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: RoutePath.home,
          name: RouteNamed.home,
          routes: [
            TypedGoRoute<VideoAudioRoute>(path: RoutePath.videoAudio, name: RouteNamed.videoAudio),
            TypedGoRoute<PostRoute>(path: RoutePath.post, name: RouteNamed.post),
            TypedGoRoute<LivestreamListRoute>(
              path: RoutePath.livestreamList,
              name: RouteNamed.livestreamList,
              routes: [
                //? Home Sub Page - Livestream User
                TypedGoRoute<LivestreamRoute>(path: RoutePath.livestream, name: RouteNamed.livestream),
                //? Home Sub Page - Livestream Censor
                TypedGoRoute<LiveCensorFormRoute>(
                  path: RoutePath.liveCensorForm,
                  name: RouteNamed.liveCensorForm,
                  routes: [
                    TypedGoRoute<LiveCensorResultRoute>(
                      path: RoutePath.liveCensorResult,
                      name: RouteNamed.liveCensorResult,
                    ),
                  ],
                ),
                TypedGoRoute<LivestreamWhellWebViewRoute>(
                  path: RoutePath.liveWhellWebview,
                  name: RouteNamed.liveWhellWebview,
                ),
                TypedGoRoute<LivestreamEventRoute>(
                  path: RoutePath.livestreamEvent,
                  name: RouteNamed.livestreamEvent,
                ),
                //? Home Sub Page - Livestream Employee
                TypedGoRoute<LiveScheduleListRoute>(
                  path: RoutePath.liveScheduleList,
                  name: RouteNamed.liveScheduleList,
                  routes: [
                    TypedGoRoute<LiveBreakRequestRoute>(
                      path: RoutePath.liveBreakRequest,
                      name: RouteNamed.liveBreakRequest,
                      routes: [
                        TypedGoRoute<LiveBreakListRoute>(
                          path: RoutePath.liveBreakList,
                          name: RouteNamed.liveBreakList,
                          routes: [
                            TypedGoRoute<LiveBreakDetailRoute>(
                              path: RoutePath.liveBreakDetail,
                              name: RouteNamed.liveBreakDetail,
                            ),
                          ],
                        ),
                      ],
                    ),
                    TypedGoRoute<LiveScheduleDetailRoute>(
                      path: RoutePath.liveScheduleDetail,
                      name: RouteNamed.liveScheduleDetail,
                      routes: [
                        TypedGoRoute<LivestreamEmployeeRoute>(
                          path: RoutePath.livestreamEmployee,
                          name: RouteNamed.livestreamEmployee,
                          routes: [
                            TypedGoRoute<EndLiveRoute>(path: RoutePath.endLive, name: RouteNamed.endLive),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TypedGoRoute<SearchRoute>(path: RoutePath.search, name: RouteNamed.search),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<VNSShopShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ShopRoute>(
          path: RoutePath.vnsShop,
          name: RouteNamed.vnsShop,
          routes: [
            TypedGoRoute<DeliveryAddressRoute>(
              path: RoutePath.deliveryAddress,
              name: RouteNamed.deliveryAddress,
              routes: [
                // editAddress
                TypedGoRoute<EditAddressRoute>(
                  path: RoutePath.editAddress,
                  name: RouteNamed.editAddress,
                ),

                TypedGoRoute<NewAddressRoute>(
                  path: RoutePath.newAddress,
                  name: RouteNamed.newAddress,
                ),
              ],
            ),
            TypedGoRoute<FindProductRoute>(
              path: RoutePath.findProduct,
              name: RouteNamed.findProduct,
            ),
            TypedGoRoute<ShopPaymentMethodRoute>(
              path: RoutePath.shopPaymentMethod,
              name: RouteNamed.shopPaymentMethod,
              routes: [
                TypedGoRoute<BankAccountRefundRoute>(
                  path: RoutePath.bankAccountRefund,
                  name: RouteNamed.bankAccountRefund,
                )
              ],
            ),
            TypedGoRoute<TermsOfPurchaseSalePolicyRoute>(
              path: RoutePath.termsOfPurchaseSalePolicy,
              name: RouteNamed.termsOfPurchaseSalePolicy,
            ),
            TypedGoRoute<SupportRoute>(
              path: RoutePath.support,
              name: RouteNamed.support,
              routes: [
                TypedGoRoute<UserRequestRoute>(
                  path: RoutePath.userRequest,
                  name: RouteNamed.userRequest,
                ),
              ],
            ),
            TypedGoRoute<SundayPromotionRoute>(
              path: RoutePath.sundayPromotion,
              name: RouteNamed.sundayPromotion,
            ),
            TypedGoRoute<ResultFindProductRoute>(
              path: RoutePath.resultFindProduct,
              name: RouteNamed.resultFindProduct,
            ),
            TypedGoRoute<FlashSaleRoute>(
              path: RoutePath.flashSale,
              name: RouteNamed.flashSale,
            ),
            TypedGoRoute<OffersAndEventsRoute>(
              path: RoutePath.offersAndEvents,
              name: RouteNamed.offersAndEvents,
              routes: [
                TypedGoRoute<OffersAndEventsDetailRoute>(
                  path: RoutePath.offersAndEventsDetail,
                  name: RouteNamed.offersAndEventsDetail,
                ),
              ],
            ),
            TypedGoRoute<ProductDetailRoute>(path: RoutePath.productDetail, name: RouteNamed.productDetail, routes: [
              TypedGoRoute<ProductReviewRoute>(
                path: RoutePath.productReview,
                name: RouteNamed.productReview,
              ),
              TypedGoRoute<VideoProductRoute>(
                path: RoutePath.videoProduct,
                name: RouteNamed.videoProduct,
              )
            ]),
            TypedGoRoute<CartRoute>(
              path: RoutePath.cart,
              name: RouteNamed.cart,
              routes: [
                TypedGoRoute<OrderSummaryRoute>(path: RoutePath.orderSummary, name: RouteNamed.orderSummary, routes: [
                  TypedGoRoute<PaymentSuccessRoute>(
                    path: RoutePath.paymentSuccess,
                    name: RouteNamed.paymentSuccess,
                  )
                ]),
                TypedGoRoute<OrderStatusDetailRoute>(
                  path: RoutePath.orderStatusDetail,
                  name: RouteNamed.orderStatusDetail,
                ),
              ],
            ),
            TypedGoRoute<OrderRoute>(
              path: RoutePath.order,
              name: RouteNamed.order,
              routes: [
                TypedGoRoute<OrderStatusRoute>(
                  path: RoutePath.orderStatus,
                  name: RouteNamed.orderStatus,
                ),
                TypedGoRoute<CancelOrderRoute>(
                  path: RoutePath.cancelOrder,
                  name: RouteNamed.cancelOrder,
                ),
                TypedGoRoute<RefundOrderRoute>(
                  path: RoutePath.refundOrder,
                  name: RouteNamed.refundOrder,
                ),
              ],
            ),
            TypedGoRoute<UserReviewRoute>(
              path: RoutePath.userReview,
              name: RouteNamed.userReview,
            ),
            TypedGoRoute<GiftShopRoute>(
              path: RoutePath.giftShop,
              name: RouteNamed.giftShop,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<NewPostShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CameraRoute>(
          path: RoutePath.camera,
          name: RouteNamed.camera,
          routes: [
            TypedGoRoute<VideoPreviewRoute>(
              path: RoutePath.videoPreview,
              name: RouteNamed.videoPreview,
            ),
            TypedGoRoute<CreatePostRoute>(
              path: RoutePath.createPost,
              name: RouteNamed.createPost,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<NotificationShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<NotificationRoute>(
          path: RoutePath.notification,
          name: RouteNamed.notification,
          routes: [
            TypedGoRoute<NewFollowerRoute>(
              path: RoutePath.newFollower,
              name: RouteNamed.newFollower,
            ),
            TypedGoRoute<SystemNotificationRoute>(
              path: RoutePath.systemNotification,
              name: RouteNamed.systemNotification,
              routes: [
                TypedGoRoute<SystemNotificationDetailRoute>(
                  path: RoutePath.systemNotificationDetail,
                  name: RouteNamed.systemNotificationDetail,
                ),
                TypedGoRoute<ActionNotificationRoute>(
                  path: RoutePath.actionNotification,
                  name: RouteNamed.actionNotification,
                ),
                TypedGoRoute<FriendRoute>(
                  path: RoutePath.friend,
                  name: RouteNamed.friend,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(
          path: RoutePath.profile,
          name: RouteNamed.profile,
          routes: [
            TypedGoRoute<ProfilePreviewRoute>(
              path: RoutePath.profilePreview,
              name: RouteNamed.profilePreview,
            ),
            TypedGoRoute<EditInfoRoute>(
              path: RoutePath.editInfo,
              name: RouteNamed.editInfo,
            ),
            TypedGoRoute<UserQRRoute>(
              path: RoutePath.userQR,
              name: RouteNamed.userQR,
              routes: [
                TypedGoRoute<QRScanRoute>(path: RoutePath.qrScanner, name: RouteNamed.qrScanner),
              ],
            ),
            TypedGoRoute<WalletRoute>(
              path: RoutePath.wallet,
              name: RouteNamed.wallet,
              routes: [
                TypedGoRoute<TransactionDetailsRoute>(
                  path: RoutePath.transactionDetails,
                  name: RouteNamed.transactionDetails,
                ),
                TypedGoRoute<RequestWithdrawalsRoute>(
                  path: RoutePath.requestWithdrawals,
                  name: RouteNamed.requestWithdrawals,
                  routes: [
                    TypedGoRoute<RequestSuccessRoute>(
                      path: RoutePath.requestSuccess,
                      name: RouteNamed.requestSuccess,
                    ),
                  ],
                ),
                TypedGoRoute<ContactRoute>(
                  path: RoutePath.contact,
                  name: RouteNamed.contact,
                ),
                TypedGoRoute<PaymentMethodRoute>(
                  path: RoutePath.paymentMethod,
                  name: RouteNamed.paymentMethod,
                  routes: [
                    TypedGoRoute<PaymentConfirmRoute>(path: RoutePath.paymentConfirm, name: RouteNamed.paymentConfirm),
                    TypedGoRoute<VnpayWebViewRoute>(path: RoutePath.vnpayWebView, name: RouteNamed.vnpayWebView),
                  ],
                ),
                TypedGoRoute<SettingRoute>(
                  path: RoutePath.setting,
                  name: RouteNamed.setting,
                  routes: [
                    TypedGoRoute<AccountRoute>(path: RoutePath.account, name: RouteNamed.account),
                    TypedGoRoute<PolicyTermsRoute>(path: RoutePath.policyTerms, name: RouteNamed.policyTerms),
                    TypedGoRoute<LanguageRoute>(path: RoutePath.language, name: RouteNamed.language),
                    TypedGoRoute<NotificationSettingRoute>(
                        path: RoutePath.notificationSetting, name: RouteNamed.notificationSetting),
                    TypedGoRoute<MemberRankRoute>(
                      path: RoutePath.memberRank,
                      name: RouteNamed.memberRank,
                      routes: [
                        TypedGoRoute<MemberRankDetailRoute>(
                            path: RoutePath.memberRankDetail, name: RouteNamed.memberRankDetail),
                        TypedGoRoute<MemberRankHistoryRoute>(
                            path: RoutePath.memberRankHistory, name: RouteNamed.memberRankHistory),
                      ],
                    ),
                    TypedGoRoute<AffiliateRoute>(path: RoutePath.affiliate, name: RouteNamed.affiliate),
                    TypedGoRoute<AffiliateRegisterRoute>(
                        path: RoutePath.affiliateRegister, name: RouteNamed.affiliateRegister),
                    TypedGoRoute<CommissionRoute>(path: RoutePath.commission, name: RouteNamed.commission),
                    TypedGoRoute<WithdrawCommissionRoute>(
                        path: RoutePath.withdrawCommission, name: RouteNamed.withdrawCommission),
                    TypedGoRoute<WithdrawCommissionSuccessRoute>(
                        path: RoutePath.withdrawCommissionSuccess, name: RouteNamed.withdrawCommissionSuccess),
                    TypedGoRoute<FindCommissionProductRoute>(
                        path: RoutePath.findCommissionProduct, name: RouteNamed.findCommissionProduct),
                  ],
                ),
                TypedGoRoute<MessageRoute>(path: RoutePath.message, name: RouteNamed.message),
                TypedGoRoute<MessageStoreRoute>(path: RoutePath.messageStore, name: RouteNamed.messageStore),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    final PageState pageState = context.watch<PageCubit>().state;
    Widget child = navigationShell;

    if (pageState.isPrimaryRoute) {
      child = ScaffoldLayout(navigationShell: navigationShell);
    }

    return CustomTransitionPage(
      name: RouteNamed.shellRoute,
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
      },
    );
  }
}

//* Shell routes - Home
class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
  // static final GlobalKey<NavigatorState> $navigatorKey = AppConfig.rootNaviKey;
  static final List<NavigatorObserver> $observers = [AppConfig.homeRouterObserver];
}

class HomeRoute extends GoRouteData {
  const HomeRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

//? Home Sub Page - Video Audio
class VideoAudioRoute extends GoRouteData {
  const VideoAudioRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const VideoAudioPage();
}

//? Home Sub Page - Post
class PostRoute extends GoRouteData {
  const PostRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const PostPage();
}

//? Home Sub Page - Find
class SearchRoute extends GoRouteData {
  const SearchRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SearchPage();
}

//? Home Sub Page - Livestream
class LivestreamListRoute extends GoRouteData {
  const LivestreamListRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LivestreamListPage();
}

class LivestreamRoute extends GoRouteData {
  const LivestreamRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LivestreamPage();
}

class LiveScheduleListRoute extends GoRouteData {
  const LiveScheduleListRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveScheduleListPage();
}

class LiveBreakRequestRoute extends GoRouteData {
  const LiveBreakRequestRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveBreakRequestPage();
}

class LiveBreakListRoute extends GoRouteData {
  const LiveBreakListRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveBreakListPage();
}

class LiveBreakDetailRoute extends GoRouteData {
  const LiveBreakDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveBreakDetailPage();
}

class LiveScheduleDetailRoute extends GoRouteData {
  const LiveScheduleDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveScheduleDetailPage();
}

class LivestreamEmployeeRoute extends GoRouteData {
  const LivestreamEmployeeRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LivestreamEmployee();
}

class EndLiveRoute extends GoRouteData {
  const EndLiveRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const EndLivePage();
}

class LiveCensorFormRoute extends GoRouteData {
  const LiveCensorFormRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveCensorFormPage();
}

class LiveCensorResultRoute extends GoRouteData {
  const LiveCensorResultRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LiveCensorResultPage();
}

class LivestreamWhellWebViewRoute extends GoRouteData {
  const LivestreamWhellWebViewRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final url = state.extra as String;
    return LivestreamWhellWebViewPage(url: url);
  }
}

class LivestreamEventRoute extends GoRouteData {
  const LivestreamEventRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LivestreamEventPage();
}

//* Shell routes - VNS Shop
class VNSShopShellBranchData extends StatefulShellBranchData {
  const VNSShopShellBranchData();
  // static final GlobalKey<NavigatorState> $navigatorKey = AppConfig.rootNaviKey;
  static final List<NavigatorObserver> $observers = [AppConfig.shopRouterObserver];
}

class ShopRoute extends GoRouteData {
  const ShopRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ShopPage();
}

class DeliveryAddressRoute extends GoRouteData {
  const DeliveryAddressRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const DeliveryAddressPage();
}

class EditAddressRoute extends GoRouteData {
  const EditAddressRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const EditAddressPage();
}

class NewAddressRoute extends GoRouteData {
  const NewAddressRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const NewAddressPage();
}

class FindProductRoute extends GoRouteData {
  const FindProductRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const FindProductPage();
}

class ShopPaymentMethodRoute extends GoRouteData {
  const ShopPaymentMethodRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ShopPaymentMethodPage();
}

class BankAccountRefundRoute extends GoRouteData {
  const BankAccountRefundRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const BankAccountRefundPage();
}

class TermsOfPurchaseSalePolicyRoute extends GoRouteData {
  const TermsOfPurchaseSalePolicyRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const TermsOfPurchaseSalePolicyPage();
}

class SupportRoute extends GoRouteData {
  const SupportRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SupportPage();
}

class UserRequestRoute extends GoRouteData {
  const UserRequestRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const UserRequestPage();
}

class SundayPromotionRoute extends GoRouteData {
  const SundayPromotionRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SundayPromotionPage();
}

class ResultFindProductRoute extends GoRouteData {
  const ResultFindProductRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ResultFindProductPage();
}

class FlashSaleRoute extends GoRouteData {
  const FlashSaleRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const FlashSalePage();
}

class OffersAndEventsRoute extends GoRouteData {
  const OffersAndEventsRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OffersAndEventsPage();
}

class OffersAndEventsDetailRoute extends GoRouteData {
  const OffersAndEventsDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OffersAndEventsDetailPage();
}

class ProductDetailRoute extends GoRouteData {
  const ProductDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProductDetailPage();
}

class ProductReviewRoute extends GoRouteData {
  const ProductReviewRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProductReviewPage();
}

class VideoProductRoute extends GoRouteData {
  const VideoProductRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const VideoProductPage();
}

class CartRoute extends GoRouteData {
  const CartRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const CartPage();
}

class OrderRoute extends GoRouteData {
  const OrderRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const OrderPage();
}

class OrderSummaryRoute extends GoRouteData {
  const OrderSummaryRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OrderSummaryPage();
}

class OrderStatusRoute extends GoRouteData {
  const OrderStatusRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OrderStatusPage();
}

class OrderStatusDetailRoute extends GoRouteData {
  const OrderStatusDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OrderStatusDetailPage();
}

class PaymentSuccessRoute extends GoRouteData {
  const PaymentSuccessRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const PaymentSuccessPage();
}

//* Shell routes - Create Post / Plus
class NewPostShellBranchData extends StatefulShellBranchData {
  const NewPostShellBranchData();
  // static final GlobalKey<NavigatorState> $navigatorKey = AppConfig.rootNaviKey;
  static final List<NavigatorObserver> $observers = [AppConfig.createPostRouterObserver];
}

class PlusRoute extends GoRouteData {
  const PlusRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const CreatePostPage();
}

class CameraRoute extends GoRouteData {
  const CameraRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const CameraPage();
}

class VideoPreviewRoute extends GoRouteData {
  const VideoPreviewRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const VideoPreviewPage();
}

class CreatePostRoute extends GoRouteData {
  const CreatePostRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const CreatePostPage();
}

class CancelOrderRoute extends GoRouteData {
  const CancelOrderRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const CancelOrderPage();
}

class RefundOrderRoute extends GoRouteData {
  const RefundOrderRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const RefundOrderPage();
}

class UserReviewRoute extends GoRouteData {
  const UserReviewRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const UserReviewPage();
}

//* Shell routes - Notification
class NotificationShellBranchData extends StatefulShellBranchData {
  const NotificationShellBranchData();
  // static final GlobalKey<NavigatorState> $navigatorKey = AppConfig.rootNaviKey;
  static final List<NavigatorObserver> $observers = [AppConfig.notificationRouterObserver];
}

class NotificationRoute extends GoRouteData {
  const NotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const NotificationPage();
}

class NewFollowerRoute extends GoRouteData {
  const NewFollowerRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const NewFollowerPage();
}

class SystemNotificationRoute extends GoRouteData {
  const SystemNotificationRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SystemNotificationPage();
}

class GiftShopRoute extends GoRouteData {
  const GiftShopRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const GiftShopPage();
}

class ActionNotificationRoute extends GoRouteData {
  const ActionNotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ActionNotiPage();
}

class SystemNotificationDetailRoute extends GoRouteData {
  const SystemNotificationDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SystemNotiDetailPage();
}

class FriendRoute extends GoRouteData {
  const FriendRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const FriendPage();
}

//* Shell routes - Profile
class ProfileShellBranchData extends StatefulShellBranchData {
  const ProfileShellBranchData();
  // static final GlobalKey<NavigatorState> $navigatorKey = AppConfig.rootNaviKey;
  static final List<NavigatorObserver> $observers = [AppConfig.profileRouterObserver];
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();
}

class ProfilePreviewRoute extends GoRouteData {
  const ProfilePreviewRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePreviewPage();
}

class EditInfoRoute extends GoRouteData {
  const EditInfoRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const EditInfoPage();
}

class UserQRRoute extends GoRouteData {
  const UserQRRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const UserQRPage();
}

class QRScanRoute extends GoRouteData {
  const QRScanRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const QRScanPage();
}

class WalletRoute extends GoRouteData {
  const WalletRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const WalletPage();
}

class TransactionDetailsRoute extends BaseTransitionRouteData {
  const TransactionDetailsRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final id = state.extra as int;
    return TransactionDetailsPage(id: id);
  }
}

class RequestWithdrawalsRoute extends BaseTransitionRouteData {
  const RequestWithdrawalsRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) => const RequestWithdrawalsPage();
}

class RequestSuccessRoute extends BaseTransitionRouteData {
  const RequestSuccessRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final id = state.extra as int;
    return RequestSuccessPage(id: id);
  }
}

class ContactRoute extends GoRouteData {
  const ContactRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ContactPage();
}

class PaymentMethodRoute extends BaseTransitionRouteData {
  const PaymentMethodRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final package = state.extra as Package;
    return PaymentMethodPage(package: package);
  }
}

class PaymentConfirmRoute extends BaseTransitionRouteData {
  const PaymentConfirmRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final id = state.extra as int;
    return PaymentConfirmPage(id: id);
  }
}

class VnpayWebViewRoute extends GoRouteData {
  const VnpayWebViewRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => VnpayWebViewPage(url: state.extra as String);
}

class SettingRoute extends GoRouteData {
  const SettingRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingPage();
}

class AccountRoute extends GoRouteData {
  const AccountRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const AccountPage();
}

class PolicyTermsRoute extends GoRouteData {
  const PolicyTermsRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const PolicyTermsPage();
}

class LanguageRoute extends GoRouteData {
  const LanguageRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const LanguagePage();
}

class MemberRankRoute extends GoRouteData {
  const MemberRankRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const MemberRankPage();
}

class AffiliateRoute extends GoRouteData {
  const AffiliateRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const AffiliatePage();
}

class AffiliateRegisterRoute extends GoRouteData {
  const AffiliateRegisterRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const AffiliateRegisterPage();
}

class CommissionRoute extends GoRouteData {
  const CommissionRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const CommissionPage();
}

class WithdrawCommissionRoute extends GoRouteData {
  const WithdrawCommissionRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const WithdrawCommissionPage();
}

class WithdrawCommissionSuccessRoute extends GoRouteData {
  const WithdrawCommissionSuccessRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const WithdrawCommissionSuccessPage();
}

class FindCommissionProductRoute extends GoRouteData {
  const FindCommissionProductRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const FindCommissionProductPage();
}

class MemberRankDetailRoute extends GoRouteData {
  const MemberRankDetailRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final Rank rank = state.extra as Rank;
    return MemberRankDetailPage(rank: rank);
  }
}

class MemberRankHistoryRoute extends GoRouteData {
  const MemberRankHistoryRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const MemberRankHistoryPage();
}

class NotificationSettingRoute extends GoRouteData {
  const NotificationSettingRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const NotificationSettingPage();
}

class MessageRoute extends BaseTransitionRouteData {
  const MessageRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final conversation = state.extra as Conversation;
    return MessagePage(conversation: conversation);
  }
}

class MessageStoreRoute extends BaseTransitionRouteData {
  const MessageStoreRoute();
  // static final GlobalKey<NavigatorState> $parentNavigatorKey = AppConfig.rootNaviKey;

  @override
  Widget buildPageWidget(BuildContext context, GoRouterState state) {
    final conversation = state.extra as Conversation;
    return MessageStorePage(conversation: conversation);
  }
}

//* General Routes
@TypedGoRoute<ImageViewRoute>(path: RoutePath.imageView, name: RouteNamed.imageView)
class ImageViewRoute extends GoRouteData {
  const ImageViewRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => ImageViewPage(url: state.extra as String);
}
