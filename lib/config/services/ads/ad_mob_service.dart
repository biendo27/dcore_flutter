part of '../services.dart';

// mixin AdMobService {
//   static BannerAd? _bannerAd;
//   static InterstitialAd? _interstitialAd;
//   static RewardedAd? _rewardedAd;
//   static RewardedInterstitialAd? _rewardedInterstitialAd;
//   static NativeAd? _nativeAd;

//   static void init() => MobileAds.instance.initialize();

//   static void addAds({bool interstitial = false, bool bannerAd = false, bool rewardedAd = false, bool nativeAd = false, int? bannerAdWidth, int? bannerAdHeight}) {
//     if (interstitial) {
//       loadInterstitialAd();
//     }

//     if (bannerAd) {
//       loadBannerAd(width: bannerAdWidth, maxHeight: bannerAdHeight);
//     }

//     if (rewardedAd) {
//       loadRewardedAd();
//     }

//     if (nativeAd) {
//       loadNativeAd();
//     }
//   }

//   static Future<void> loadBannerAd({int? width, int? maxHeight}) async {
//     // String bannerAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111";
//     String bannerAdId = 'ca-app-pub-7030564084462348/9008476307';
//     AdSize? size = width != null || maxHeight != null ? AdSize(width: width!, height: maxHeight!) : null;
//     _bannerAd = BannerAd(
//       adUnitId: bannerAdId,
//       size: size ?? AdSize.largeBanner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdClicked: (ad) => LogDev.data('AdMob BannerAd clicked.'),
//         onAdClosed: (ad) => LogDev.data('AdMob BannerAd closed.'),
//         onAdFailedToLoad: (ad, error) {
//           LogDev.error('AdMob BannerAd failed to load: $error');
//           ad.dispose();
//         },
//         onAdImpression: (ad) => LogDev.data('AdMob BannerAd impression.'),
//         onAdLoaded: (ad) => LogDev.data('AdMob BannerAd loaded.'),
//         onAdOpened: (ad) => LogDev.data('AdMob BannerAd opened.'),
//         onAdWillDismissScreen: (ad) => LogDev.error('AdMob BannerAd will dismiss screen.'),
//         onPaidEvent: (ad, valueMicros, precision, currencyCode) => LogDev.data('AdMob BannerAd paid event.'),
//       ),
//     );

//     _bannerAd?.load();
//   }

//   static void loadNativeAd() {
//     // String nativeAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/3986624511" : "ca-app-pub-3940256099942544/2247696110";
//     String nativeAdId = 'ca-app-pub-7030564084462348/8016379718';

//     NativeAd.fromAdManagerRequest(
//       adUnitId: nativeAdId,
//       listener: NativeAdListener(
//         onAdLoaded: (ad) => LogDev.data('AdMob NativeAd loaded.'),
//         onAdFailedToLoad: (ad, error) {
//           // Dispose the ad here to free resources.
//           LogDev.error('AdMob NativeAd failed to load: $error');
//           ad.dispose();
//         },
//         onAdOpened: (ad) => LogDev.data('AdMob NativeAd opened.'),
//         onAdClosed: (ad) => LogDev.data('AdMob NativeAd closed.'),
//         onAdClicked: (ad) => LogDev.data('AdMob NativeAd clicked.'),
//         onAdImpression: (ad) => LogDev.data('AdMob NativeAd impression.'),
//         onAdWillDismissScreen: (ad) => LogDev.data('AdMob NativeAd will dismiss screen.'),
//         onPaidEvent: (ad, valueMicros, precision, currencyCode) => LogDev.data('AdMob NativeAd paid event.'),
//       ),
//       adManagerRequest: const AdManagerAdRequest(),
//       nativeTemplateStyle: NativeTemplateStyle(
//         // Required: Choose a template.
//         templateType: TemplateType.medium,
//         // Optional: Customize the ad's style.
//         mainBackgroundColor: Colors.purple,
//         cornerRadius: 10.0,
//         callToActionTextStyle: NativeTemplateTextStyle(textColor: Colors.cyan, backgroundColor: Colors.red, style: NativeTemplateFontStyle.monospace, size: 16.0),
//         primaryTextStyle: NativeTemplateTextStyle(textColor: Colors.red, backgroundColor: Colors.cyan, style: NativeTemplateFontStyle.italic, size: 16.0),
//         secondaryTextStyle: NativeTemplateTextStyle(textColor: Colors.green, backgroundColor: Colors.black, style: NativeTemplateFontStyle.bold, size: 16.0),
//         tertiaryTextStyle: NativeTemplateTextStyle(textColor: Colors.brown, backgroundColor: Colors.amber, style: NativeTemplateFontStyle.normal, size: 16.0),
//       ),
//     );
//   }

//   static void loadRewardedAd() {
//     // String rewardedAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/1712485313" : "ca-app-pub-3940256099942544/5224354917";
//     String rewardedAdId = 'ca-app-pub-7030564084462348/4268706393';

//     RewardedAd.load(
//       adUnitId: rewardedAdId,
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (RewardedAd ad) {
//           _rewardedAd = ad;
//           LogDev.data('AdMob RewardedAd loaded.');
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           _rewardedAd = null;
//           LogDev.error('AdMob RewardedAd failed to load: $error');
//         },
//       ),
//     );
//   }

//   static void loadInterstitialAd() {
//     // String interstitialAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-3940256099942544/1033173712";
//     String interstitialAdId = 'ca-app-pub-7030564084462348/1834114748';

//     InterstitialAd.load(
//       adUnitId: interstitialAdId,
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           // Keep a reference to the ad so you can show it later.
//           _interstitialAd = ad;

//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (InterstitialAd ad) {
//               ad.dispose();
//               LogDev.error('AdMob InterstitialAd dismissed.');
//               loadInterstitialAd();
//             },
//             onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//               ad.dispose();
//               LogDev.error('AdMob InterstitialAd failed to show: $error');
//               loadInterstitialAd();
//             },
//           );
//         },
//         onAdFailedToLoad: (LoadAdError error) => LogDev.error('AdMob InterstitialAd failed to load: $error'),
//       ),
//     );
//   }

//   static void loadRewardedInterstitialAd() {
//     String rewardedInterstitialAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/5354046379" : "ca-app-pub-3940256099942544/5354046379";

//     RewardedInterstitialAd.load(
//       adUnitId: rewardedInterstitialAdId,
//       request: const AdRequest(),
//       rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           LogDev.data('AdMob RewardedInterstitialAd $ad loaded.');
//           // Keep a reference to the ad so you can show it later.
//           _rewardedInterstitialAd = ad;
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (LoadAdError error) => LogDev.error('RewardedInterstitialAd failed to load: $error'),
//       ),
//     );
//   }

//   static BannerAd? getBannerAd() {
//     return _bannerAd;
//   }

//   static NativeAd? getNativeAd() {
//     return _nativeAd;
//   }

//   static void showInterstitial() {
//     _interstitialAd?.show();
//   }

//   static void showRewardedAd() {
//     if (_rewardedAd != null) {
//       _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedAd ad) {
//         LogDev.data("AD ON AD SHOWED FULL SCREEN CONTENT");
//       }, onAdDismissedFullScreenContent: (RewardedAd ad) {
//         ad.dispose();
//         loadRewardedAd();
//         LogDev.error("AD ON AD DISMISSED FULL SCREEN CONTENT");
//       }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         ad.dispose();
//         loadRewardedAd();
//       });

//       _rewardedAd!.setImmersiveMode(true);
//       _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//         LogDev.data("AD REWARD ACTIVE: ${reward.amount} ${reward.type}");
//       });
//     }
//   }

//   static void showRewardedInterstitialAd() {
//     if (_rewardedInterstitialAd != null) {
//       _rewardedInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedInterstitialAd ad) {
//         LogDev.data("AD ON AD SHOWED FULL SCREEN CONTENT");
//       }, onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
//         ad.dispose();
//         loadRewardedInterstitialAd();
//         LogDev.error("AD ON AD DISMISSED FULL SCREEN CONTENT");
//       }, onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) {
//         ad.dispose();
//         loadRewardedInterstitialAd();
//         LogDev.error("AD ON AD FAILED TO SHOW FULL SCREEN CONTENT");
//       });

//       _rewardedInterstitialAd!.setImmersiveMode(true);
//       _rewardedInterstitialAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//         LogDev.data("AD REWARD ACTIVE: ${reward.amount} ${reward.type}");
//       });
//     }
//   }

//   static void disposeAds() {
//     _bannerAd?.dispose();
//     _nativeAd?.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//     _rewardedInterstitialAd?.dispose();
//   }
// }
