part of '../constants.dart';

mixin AppEndpoint {
  //* Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String loginZalo = '/login-zalo';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String resendOTP = '/resend-otp';
  static const String verifyOTP = '/verify-otp';
  static const String updatePassword = '/user/update-password';
  static const String deletePermanentUser = '/user/delete-permanently-user';

  //* Terms
  static const String terms = '/terms';

  //* Geographical
  static const String nation = '/nation';
  static const String city = '/city';
  static const String district = '/district';
  static const String ward = '/ward';

  //* User
  //? Wallet
  static const String wallet = '/user/wallet';
  static const String walletWithdraw = '/user/wallet/withdraw';
  static const String walletDetail = '/user/wallet/detail';
  static const String walletChangeCoinToMoney = '/user/wallet/change-coin-to-money';
  static const String walletPackage = '/user/wallet/package';
  static const String walletPolicy = '/user/wallet/virtual-item-policy';
  static const String walletPaymentMethod = '/user/wallet/payment-method';
  static const String walletDeposit = '/user/wallet/deposit';
  static const String walletBanking = '/user/wallet/banking';
  static const String walletUploadDeposit = '/user/wallet/upload-deposit';
  static const String walletInAppPurchase = '/user/wallet/in-app-purchase';
  static const String walletCreatePaymentVNPayTransaction = '/service/create-payment-vnpay-transaction';
  static const String walletCreatePaymentVNPayOrder = '/service/create-payment-vnpay-order';

  //? Rank
  static const String rank = '/user/rank';
  static const String rankHistory = '/user/rank/history';
  static const String rankDetail = '/user/rank/detail';

  //? Billing Address
  static const String billingAddress = '/user/billing-address';
  static const String billingAddressCreate = '/user/billing-address/create';
  static const String billingAddressUpdate = '/user/billing-address/update';
  static const String nationList = '/national';
  static const String cityList = '/city';
  static const String districtList = '/district';
  static const String wardList = '/ward';

  //? Refund Banking
  static const String refundBanking = '/user/refund-banking';
  static const String refundBankingUpdate = '/user/refund-banking/update';
  static const String refundBankingListBankData = '/user/refund-banking/banks';

  //? Profile
  static const String profile = '/user/get-profile';
  static const String myProfile = '/user/my-profile';
  static const String profileUpdate = '/user/update';
  static const String userPost = '/user/post';
  static const String userPostBookmarkList = '/user/post-bookmark-list';
  static const String userSoundBookmarkList = '/user/sound-bookmark-list';
  static const String userFilterBookmarkList = '/user/filter-bookmark-list';
  static const String userProductBookmarkList = '/user/product-bookmark-list';
  static const String userLikePost = '/user/like';
  static const String userBookmark = '/user/bookmark';
  static const String updateLanguage = '/user/update-language';

  //? Follow
  static const String userList = '/user';
  static const String updateUserFollow = '/user/update-user-follow';
  static const String removeSuggestion = '/user/remove-suggestion';

  //? Activity
  static const String userOrder = '/user/order';
  static const String searchHistory = '/search-history';

  //? Socket
  static const String updateUserSocketId = '/user/update-socket';

  //? Review
  static const String userReview = '/user/review';
  static const String userReviewPending = '/user/review-pending';

  //* Post
  static const String getPostList = '/post/get-post-list';
  static const String getPostDetail = '/post/get-post-detail';
  static const String createPost = '/post/create-post';
  static const String updateLikePost = '/post/update-like-post';
  static const String updateBookmarkPost = '/post/update-bookmark-post';
  static const String getPostComment = '/post/get-post-comment';
  static const String createPostComment = '/post/create-post-comment';
  static const String deletePostComment = '/post/delete-post-comment';
  static const String deletePost = '/post/delete-post';
  static const String updateLikePostComment = '/post/update-like-post-comment';
  static const String reportPost = '/post/report-post';
  static const String markAsReadPost = '/post/mark-as-read';
  static const String searchPost = '/post/search-post';
  static const String searchUser = '/post/search-user';

  //* Sound
  static const String createSound = '/sound/create';
  static const String soundBookmarked = '/sound/get-sound-bookmarked-list';
  static const String soundDetail = '/sound/get-sound-detail';
  static const String soundSuggestedList = '/sound/get-sound-suggested-list';
  static const String updateBookmarkSound = '/sound/update-bookmark-sound';

  //* Hashtag
  static const String hashtag = '/hash-tag';

  //* Config
  static const String config = '/config';
  static const String appName = '/config/app-name';
  static const String splash = '/config/splashes';
  static const String termsOfUseApp = '/config/terms-of-use-app';
  static const String termsOfSalePolicy = '/config/terms-of-sale-policy';
  static const String privacyPolicy = '/config/privacy-policy';

  //* Sell
  static const String sell = '/sell';
  static const String flashSell = '/sell/flash-sale';

  //? Event
  static const String sellEvent = '/sell/event';
  static const String sellEventDetail = '/sell/event/detail';

  //? Product
  static const String product = '/sell/product';
  static const String productFilter = '/sell/product/filter';
  static const String productDetail = '/sell/product/detail';
  static const String productReview = '/sell/product/review';
  static const String productPost = '/sell/product/post';
  static const String otherProduct = '/sell/product/other-product';
  static const String productVoucher = '/sell/product/voucher';
  static const String productService = '/sell/product/service';
  static const String productServiceDetail = '/sell/product/service/detail';
  static const String productBookmark = '/sell/product/bookmark';
  static const String productSuggest = '/sell/product/suggest';
  static const String productCancelOrderTutorialTerm = '/sell/product/cancel-order-tutorial-term';

  //? Voucher
  static const String voucher = '/sell/voucher';
  static const String voucherDetail = '/sell/voucher/detail';
  static const String voucherAdd = '/sell/voucher/add';
  static const String voucherSave = '/sell/voucher/save-voucher';
  static const String voucherUsageTerms = '/sell/voucher/usage_terms';

  //? Cart
  static const String cart = '/sell/cart';
  static const String cartGetProductByVariant = '/sell/cart/get-price-by-variant';
  static const String cartAdd = '/sell/cart/add';
  static const String cartUpdate = '/sell/cart/update';
  static const String cartDelete = '/sell/cart/delete';

  //? Order
  static const String order = '/sell/order';
  static const String orderDetail = '/sell/order/detail';
  static const String orderStatuses = '/sell/order/statuses';
  static const String orderInfoUpdate = '/sell/order/infor';
  static const String orderSave = '/sell/order/save';
  static const String orderStoreVoucher = '/sell/voucher/store';
  static const String orderVoucher = '/sell/voucher/order';
  static const String orderGetVoucherByCode = '/sell/voucher/get-voucher-by-code';
  static const String orderSendMail = '/sell/order/send-mail';
  static const String orderGetReview = '/sell/order/review';
  static const String orderReview = '/sell/order/review/add';
  static const String orderStatus = '/sell/order/status';
  static const String orderCancelInfo = '/sell/order/show-cancel';
  static const String orderCancelCategories = '/sell/order/cancel-order-categories';
  static const String orderCancelSave = '/sell/order/cancel';
  static const String orderReturnInfo = '/sell/order/return/show';
  static const String orderReturnCategories = '/sell/order/return/category';
  static const String orderReturnCreate = '/sell/order/return/create';
  static const String orderPaymentMethod = '/sell/order/payment-method';
  static const String orderReceiveConfirm = '/sell/order/receive-confirm';

  //* Gift
  static const String getGiftList = '/gift/get-gift-list';
  static const String createGift = '/gift/create-gift';
  static const String giveGift = '/gift/give-gift';
  static const String giveGiftShop = '/live/wheel-history';

  //* Affiliate
  static const String affiliateRequest = '/user/affiliate/request';
  static const String affiliateRegister = '/user/affiliate/register';
  static const String affiliateUpdate = '/user/affiliate/update-info';
  static const String affiliateHome = '/user/affiliate/home';
  static const String affiliateCommission = '/user/affiliate/commission';
  static const String affiliateInfo = '/user/affiliate/info';
  static const String affiliateMoneyToCoin = '/user/affiliate/change-money-to-coin';
  static const String affiliateWithdraw = '/user/affiliate/withdraw';
  static const String affiliateProductList = '/user/affiliate/product-list';
  static const String affiliateAddProduct = '/user/affiliate/add-product';
  static const String affiliateProduct = '/user/affiliate/product';

  //* Notification
  static const String getNotificationList = '/notification/get-notification-list';
  static const String getNewFollowerNotificationDetail = '/notification/get-new-follower-notification-detail';
  static const String getActivityNotificationDetail = '/notification/get-activity-notification-detail';
  static const String getSystemNotificationDetail = '/notification/get-system-notification-detail';
  static const String getSuggestUser = '/user/get-suggested-user';
  static const String pushNotificationToSingleUser = '/user/push-notification-to-single-user';

  //* Live
  static const String liveList = '/live';
  static const String liveDetail = '/live/detail';
  static const String createLive = '/live/create';
  static const String startLive = '/live/start-live';
  static const String cancelLive = '/live/cancel-live-request';
  static const String endLive = '/live/end-live';
  static const String createLeaveRequest = '/live/create-leave-request';
  static const String getLeaveRequest = '/live/get-leave-requests';
  static const String getLeaveRequestDetail = '/live/get-leave-request-detail';
  static const String deleteLeaveRequest = '/live/delete-leave-request';
  static const String createLiveRequest = '/live/create-live-request';
  static const String getLiveRequest = '/live/get-live-requests';
  static const String getLiveRequestDetail = '/live/live-request-detail';
  static const String deleteLiveRequest = '/live/delete-live-request';
  static const String livePlatforms = '/live/platform';
  static const String liveAreas = '/live/area';
  static const String mySchedule = '/live/my-schedule';
  static const String myNearestLive = '/live/my-nearest-live';
  static const String myScheduleDetail = '/live/my-schedule-detail';
  static const String updatePinProductToLive = '/live/update-pin-product-to-live';
  static const String updatePinCommentToLive = '/live/update-pin-comment-to-live';
  static const String liveBooth = '/live/live-booth';
  static const String liveMarkAsRead = '/live/mark-as-read';
  static const String listComment = '/live/comment-list';
  static const String loadOldComment = '/live/load-old-comment';
  static const String createComment = '/live/comment';
  static const String liveLike = '/live/update-like-live';
  static const String leaveLive = '/live/leave';
  static const String liveProductOther = '/live/live-product-other';
  static const String liveExtraInfo = '/live/term-live';
  static const String liveMission = '/live/mission';
  static const String liveMissionReceive = '/live/mission/receive';
  static const String liveWhell = '/wheel';
  static const String liveRandom = '/live/gift/random';
  static const String liveEventList = '/live/live-event-list';
  static const String liveEventSubscribe = '/live/subscribe-live-event';
  static const String generateAgoraToken = '/live/generate-agora-token';

  //* Live Censor
  static const String liveCensorForm = '/live/censor/form';
  static const String liveCensorSave = '/live/censor/save';
  static const String liveCensorResultUser = '/live/censor';

  //* Search
  static const String userSearchHistory = '/user/search/history';
  static const String listKeyword = '/search';
  static const String saveKeywordHistory = '/user/search/create';
  static const String removeKeywordHistory = '/user/search/delete';

  //* Report
  static const String reportList = '/report/get-report-category-list';
  static const String reportCreate = '/report/create';

  //* News
  static const String getNewsDetail = '/news/show';

  //* Upload
  static const String upload = '/file/upload-multiple';
}

mixin ModerationEndpoint {
  static const String checkVideoBelowOneMinute = '/check-sync.json';
  static const String checkVideoAboveOneMinute = '/check.json';
}
