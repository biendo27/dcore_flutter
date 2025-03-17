part of '../services.dart';

// mixin UnityAdsService {
//   static void init() {
//     UnityAds.init(
//       gameId: '5237176',
//       // testMode: true,
//       onComplete: () => LogDev.data('UNITY ADS INITIALIZED'),
//       onFailed: (error, message) => LogDev.error('UNITY ADS INITIALIZED FAILED: $error $message'),
//     );
//   }

//   static void loadAd({bool isBanner = false, bool isInterstitial = false, bool isRewarded = false}) {
//     if (isBanner) {
//       UnityAds.load(
//         placementId: 'Banner_Android',
//         onComplete: (placementID) => LogDev.info('UNITY ADS LOADED: $placementID'),
//         onFailed: (placementId, error, message) => LogDev.error('UNITY ADS LOADED FAILED $placementId: $error $message'),
//       );
//     }

//     if (isInterstitial) {
//       UnityAds.load(
//         placementId: 'Interstitial_Android',
//         onComplete: (placementID) => LogDev.info('UNITY ADS LOADED: $placementID'),
//         onFailed: (placementId, error, message) => LogDev.error('UNITY ADS LOADED FAILED $placementId: $error $message'),
//       );
//     }

//     if (isRewarded) {
//       UnityAds.load(
//         placementId: 'Rewarded_Android',
//         onComplete: (placementID) => LogDev.info('UNITY ADS LOADED: $placementID'),
//         onFailed: (placementId, error, message) => LogDev.error('UNITY ADS LOADED FAILED $placementId: $error $message'),
//       );
//     }
//   }

//   static void showInterstitialAd() {
//     UnityAds.showVideoAd(
//       placementId: 'Interstitial_Android',
//       onStart: (placementId) => LogDev.info('Video Ad $placementId started'),
//       onClick: (placementId) => LogDev.info('Video Ad $placementId click'),
//       onSkipped: (placementId) => LogDev.info('Video Ad $placementId skipped'),
//       onComplete: (placementId) => LogDev.info('Video Ad $placementId completed'),
//       onFailed: (placementId, error, message) => LogDev.error('Video Ad $placementId failed: $error $message'),
//     );
//   }

//   static void showRewardAd() {
//     UnityAds.showVideoAd(
//       placementId: 'Rewarded_Android',
//       onStart: (placementId) => LogDev.info('Video Ad $placementId started'),
//       onClick: (placementId) => LogDev.info('Video Ad $placementId click'),
//       onSkipped: (placementId) => LogDev.info('Video Ad $placementId skipped'),
//       onComplete: (placementId) => LogDev.info('Video Ad $placementId completed'),
//       onFailed: (placementId, error, message) => LogDev.error('Video Ad $placementId failed: $error $message'),
//     );
//   }

//   static UnityBannerAd? getBannerAD({BannerSize size = BannerSize.standard}) {
//     return UnityBannerAd(
//       placementId: 'Banner_Android',
//       size: size,
//       onLoad: (placementId) => LogDev.info('Banner loaded: $placementId'),
//       onClick: (placementId) => LogDev.info('Banner clicked: $placementId'),
//       onFailed: (placementId, error, message) => LogDev.error('Banner Ad $placementId failed: $error $message'),
//     );
//   }
// }
