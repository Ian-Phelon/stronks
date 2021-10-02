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

  late bool userRemovedAds;

  @override
  void initState() {
    super.initState();

    userRemovedAds =
        UserOptions.of(context).getOptionValue(userOptionsIndex: 2);

    bool authorizedUser =
        StronksAuth.of(context).authorizedUser == AuthState.authorized;

    if (userRemovedAds && !authorizedUser) {
      userRemovedAds = false;
      myBanner.load();
    }

    if (!userRemovedAds) {
      myBanner.load();
    } else {
      myBanner.dispose();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StronksAuth.of(context).authorizedUser == AuthState.authorized &&
              userRemovedAds
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
