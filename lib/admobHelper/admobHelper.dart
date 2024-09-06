import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  // static String get bannerUnit => 'ca-app-pub-1879214842254649/6945012522'; // Replace with your real ad unit
  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';
  static void initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  // Create and load the BannerAd synchronously
  static BannerAd createBannerAd() {
    BannerAd bAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerUnit,
      listener: BannerAdListener(
        onAdClosed: (Ad ad) {
          print("Ad Closed");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        },
        onAdOpened: (Ad ad) {
          print('Ad opened');
        },
      ),
      request: const AdRequest(),
    );

    // Load the ad immediately
    bAd.load();
    return bAd;
  }
}
