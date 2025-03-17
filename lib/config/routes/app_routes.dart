part of 'routes.dart';

mixin RoutePath {
  //* General
  static const String back = '/..';
  static const String webView = '/web-view';
  static const String imageView = '/image-view';
  static const String shellRoute = '/shell-route';

  //* Splash Screen
  static const String landing = '/';
  static const String intro = '/intro';
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerAuth = '/register-auth';
  static const String forgotPassword = 'forgot-password';
  static const String otp = 'otp';
  static const String setupPassword = 'setup-password';
  static const String noAuth = '/no-auth';
  static const String changePassword = 'change-password';

  //* Home
  static const String home = '/home';
  static const String videoAudio = 'video-audio';
  static const String post = 'post';
  static const String search = 'search';

  //* Livestream
  static const String livestreamList = 'livestream-list';
  static const String livestream = 'livestream';
  static const String livestreamEvent = 'livestream-event';
  static const String liveScheduleList = 'live-schedule-list';
  static const String liveBreakRequest = 'live-break-request';
  static const String liveBreakList = 'live-break-list';
  static const String liveBreakDetail = 'live-break-detail';
  static const String liveScheduleDetail = 'live-schedule-detail';
  static const String livestreamEmployee = 'livestream-employee';
  static const String endLive = 'end-live';
  static const String liveCensorForm = 'live-censor-form';
  static const String liveCensorResult = 'live-censor';
  static const String liveWhellWebview = 'live-whell-webview';

  //* VNS Shop
  static const String vnsShop = '/dcore-shop';
  static const String deliveryAddress = 'delivery-address';
  static const String editAddress = 'edit-address';
  static const String newAddress = 'new-address';
  static const String findProduct = 'find-product';
  static const String shopPaymentMethod = 'shop-payment-method';
  static const String bankAccountRefund = 'bank-account-refund';
  static const String termsOfPurchaseSalePolicy = 'terms-of-purchase-sale-policy';
  static const String support = 'support';
  static const String userRequest = 'user-request';
  static const String sundayPromotion = 'sunday-promotion';
  static const String resultFindProduct = 'result-find-product';
  static const String flashSale = 'flash-sale';
  static const String offersAndEvents = 'offers-and-events';
  static const String offersAndEventsDetail = 'offers-and-events-detail';
  static const String productDetail = 'product-detail';
  static const String productReview = 'product-review';
  static const String videoProduct = 'video-product';
  static const String cart = 'cart';
  static const String order = 'order';
  static const String orderSummary = 'order-summary';
  static const String orderStatus = 'order-status';
  static const String paymentSuccess = 'payment-success';
  static const String orderStatusDetail = 'order-status-detail';
  static const String cancelOrder = 'cancel-order';
  static const String refundOrder = 'refund-order';
  static const String userReview = 'user-review';
  static const String giftShop = 'gift-shop';

  //* Plus
  static const String plus = '/plus';

  //* Notification
  static const String notification = '/notification';
  static const String newFollower = 'new-follower';
  static const String systemNotification = 'system-notification';
  static const String actionNotification = 'action-notification';
  static const String systemNotificationDetail = 'system-notification-detail';

  //* Friend
  static const String friend = '/friend';

  //* Profile
  static const String profile = '/profile';
  static const String editInfo = 'edit-info';
  static const String requestSuccess = 'request-success';
  static const String contact = 'contact';
  static const String profilePreview = 'profile-preview';
  static const String userQR = 'user-qr';
  static const String qrScanner = 'qr-scanner';

  //* Setting
  static const String setting = 'setting';
  static const String policyTerms = 'policy-terms';
  static const String language = 'language';
  static const String account = 'account';
  static const String notificationSetting = 'notification-setting';
  static const String memberRank = 'member-rank';
  static const String memberRankDetail = 'member-rank-detail';
  static const String memberRankHistory = 'member-rank-history';
  static const String affiliate = 'affiliate';
  static const String affiliateRegister = 'affiliate-register';
  static const String commission = 'commission';
  static const String withdrawCommission = 'withdraw-commission';
  static const String withdrawCommissionSuccess = 'withdraw-commission-success';
  static const String findCommissionProduct = 'find-commission-product';

  //* Post
  static const String camera = '/camera';
  static const String videoPreview = 'video-preview';
  static const String createPost = 'create-post';

  //*Wallet
  static const String wallet = 'wallet';
  static const String paymentMethod = 'payment-method';
  static const String paymentConfirm = 'payment-confirm';
  static const String transactionDetails = 'transaction-details';
  static const String requestWithdrawals = 'request-withdrawals';
  static const String vnpayWebView = 'vnpay-web-view';

  //* Message
  static const String message = 'message';
  static const String messageStore = 'messageStore';
}

mixin RouteNamed {
  //* General
  static const String back = 'Back';
  static const String webView = 'Web View';
  static const String imageView = 'Image View';
  static const String shellRoute = 'Shell Route';

  //* Splash Screen
  static const String landing = 'Landing Page';
  static const String intro = 'Intro Page';
  static const String splash = 'Splash Page';
  static const String login = 'Login Page';
  static const String register = 'Register Page';
  static const String registerAuth = 'Register Auth Page';
  static const String forgotPassword = 'Forgot Password Page';
  static const String otp = 'OTP Page';
  static const String setupPassword = 'Setup Password Page';
  static const String noAuth = 'No Auth Page';
  static const String changePassword = 'Change Password Page';

  //* Home
  static const String home = 'Home';
  static const String videoAudio = 'Video Audio';
  static const String post = 'Post';
  static const String search = 'Search';

  //* Livestream
  static const String livestreamList = 'Livestream List';
  static const String livestream = 'Livestream';
  static const String livestreamEvent = 'Livestream Event';
  static const String liveScheduleList = 'Live Schedule List';
  static const String liveBreakRequest = 'Live Break Request';
  static const String liveBreakList = 'Live Break List';
  static const String liveBreakDetail = 'Live Break Detail';
  static const String liveScheduleDetail = 'Live Schedule Detail';
  static const String livestreamEmployee = 'Livestream Employee';
  static const String endLive = 'End Live';
  static const String liveCensorForm = 'Live Censor Form';
  static const String liveCensorResult = 'Live Censor Result';
  static const String liveWhellWebview = 'Live Whell Web View';

  //* VNS Shop
  static const String vnsShop = 'VNS Shop';
  static const String deliveryAddress = 'Delivery Address';
  static const String editAddress = 'Edit Address';
  static const String newAddress = 'New Address';
  static const String findProduct = 'Find Product';
  static const String shopPaymentMethod = 'Shop Payment Method';
  static const String bankAccountRefund = 'Bank Account Refund';
  static const String termsOfPurchaseSalePolicy = 'Terms Of Purchase Sale Policy';
  static const String support = 'Support';
  static const String userRequest = 'User Request';
  static const String sundayPromotion = 'Sunday Promotion';
  static const String resultFindProduct = 'Result Find Product';
  static const String flashSale = 'Flash Sale';
  static const String offersAndEvents = 'Offers And Events';
  static const String offersAndEventsDetail = 'Offers And Events Detail';
  static const String productDetail = 'Product Detail';
  static const String productReview = 'Product Review';
  static const String videoProduct = 'Video Product';
  static const String cart = 'Cart';
  static const String order = 'Order';
  static const String orderSummary = 'Order Summary';
  static const String orderStatus = 'Order Status';
  static const String paymentSuccess = 'Payment Success';
  static const String orderStatusDetail = 'Order Status Detail';
  static const String cancelOrder = 'Cancel Order';
  static const String refundOrder = 'Refund Order';
  static const String userReview = 'User Review';
  static const String giftShop = 'Gift Shop';

  //* Plus
  static const String plus = 'Plus';

  //* Notification
  static const String notification = 'Notification';
  static const String newFollower = 'New Follower';
  static const String systemNotification = 'System Notification';
  static const String actionNotification = 'Action Notification';
  static const String systemNotificationDetail = 'System Notification Detail';

  //* Friend
  static const String friend = 'Friend';

  //* Profile
  static const String profile = 'Profile';
  static const String editInfo = 'Edit Info';
  static const String requestSuccess = 'Request Success';
  static const String contact = 'Contact';
  static const String profilePreview = 'Profile Preview';
  static const String userQR = 'User QR';
  static const String qrScanner = 'QR Scanner';

  //* Setting
  static const String setting = 'Setting';
  static const String policyTerms = 'Policy Terms';
  static const String language = 'Language';
  static const String account = 'Account';
  static const String notificationSetting = 'Notification Setting';
  static const String memberRank = 'Member Rank';
  static const String memberRankDetail = 'Member Rank Detail';
  static const String memberRankHistory = 'Member Rank History';
  static const String affiliate = 'Affiliate';
  static const String affiliateRegister = 'Affiliate Register';
  static const String commission = 'Commission';
  static const String withdrawCommission = 'Withdraw Commission';
  static const String withdrawCommissionSuccess = 'Withdraw Commission Success';
  static const String findCommissionProduct = 'Find Commission Product';

  //* Post
  static const String camera = 'Camera';
  static const String videoPreview = 'Video Preview';
  static const String createPost = 'Create Post';

  //* Wallet
  static const String wallet = 'Wallet';
  static const String paymentMethod = 'Payment Method';
  static const String paymentConfirm = 'Payment Confirm';
  static const String transactionDetails = 'Transaction Details';
  static const String requestWithdrawals = 'Request Withdrawals';
  static const String vnpayWebView = 'VNPay Web View';

  //* Message
  static const String message = 'Message';
  static const String messageStore = 'MessageStore';
}
