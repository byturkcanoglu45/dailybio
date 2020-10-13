import 'package:firebase_admob/firebase_admob.dart';

class AdvertServices {
  MobileAdTargetingInfo _targetingInfo;

  String bannerId = '';
  String interId = 'ca-app-pub-6064391204433118/8802193917';

  showBanner() {
    BannerAd bannerAd = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
    );

    bannerAd
      ..load()
      ..show(anchorOffset: 150, anchorType: AnchorType.bottom);

    bannerAd.dispose();
  }

  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
      adUnitId: interId,
      targetingInfo: _targetingInfo,
    );

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}
