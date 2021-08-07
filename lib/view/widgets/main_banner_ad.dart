import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../controller/controller.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8484067209507097/6321941867';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8484067209507097/2413157458';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

class MainBannerAd extends StatefulWidget {
  const MainBannerAd({Key? key}) : super(key: key);

  @override
  _MainBannerAdState createState() => _MainBannerAdState();
}

class _MainBannerAdState extends State<MainBannerAd> {
  final BannerAd myBanner = BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  late final bool userRemovedAds;

  @override
  void initState() {
    // await
    userRemovedAds =
        UserOptions.of(context).getOptionValue(userOptionsIndex: 2);
    if (userRemovedAds == false) {
      myBanner.load();
    }
    if (userRemovedAds) {
      myBanner.dispose();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: userRemovedAds
          ? const SizedBox.shrink()
          : Container(
              height: myBanner.size.height.toDouble(),
              width: myBanner.size.width.toDouble(),
              child: AdWidget(ad: myBanner),
            ),
    );
  }
}

class StronksPayments {
  /// iap goes here
}
