import 'package:flutter/material.dart';
import 'package:stronks/controller/controller.dart' show AdHelper;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Billboard extends StatefulWidget {
  @override
  _BillboardState createState() => _BillboardState();
}

class _BillboardState extends State<Billboard> {
  // COMPLETE: Add _kAdIndex
  // static final _kAdIndex = 4;

  // COMPLETE: Add a BannerAd instance
  BannerAd? _ad;

  // COMPLETE: Add _isAdLoaded
  // bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // COMPLETE: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            // _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (_, error) {
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // COMPLETE: Load an ad
    _ad?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: _ad!),
      width: _ad!.size.width.toDouble(),
      height: 72.0,
      alignment: Alignment.center,
    );
  }

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _ad?.dispose();
    super.dispose();
  }
}
