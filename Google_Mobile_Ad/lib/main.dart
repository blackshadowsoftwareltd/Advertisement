import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:googlemobileadz/constant.dart';

import 'native_ad_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///
  late BannerAd bannerAdz;
  late InterstitialAd interstitialAdz;
  bool isReady = false, isIntReady = false;

  ///
  @override
  Widget build(BuildContext context) {
    /// load interstitial ad. it support on onTap method
    Future.delayed(Duration(seconds: 5), () {
      if (isIntReady) interstitialAdz.show();
    });

    ///
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextButton(
                        child: Text(
                          'Native ad',
                          style: TextStyle(fontSize: 35),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NativeAdScreen())))),

                ///
                Container(
                    height: bannerAdz.size.height.toDouble(),
                    width: bannerAdz.size.width.toDouble(),
                    child: AdWidget(ad: bannerAdz)),
              ],
            )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// banner ad
    bannerAdz = BannerAd(
        size: AdSize.banner,
        adUnitId: AdzId.bannerId(),
        listener: BannerAdListener(
            onAdLoaded: (_) => setState(() => isReady = true),
            onAdFailedToLoad: (ad, error) {
              print('XXXXXXXXXXXXXXXXXXXXXXXX\n${error.message}');
              isReady = false;
              ad.dispose();
            }),
        request: AdRequest())
      ..load();

    /// interstitial Ad
    InterstitialAd.load(
        adUnitId: AdzId.interstitialId(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              this.interstitialAdz = ad;
              isIntReady = true;
            },
            onAdFailedToLoad: (error) =>
                print('XXXXXXXXXXXXXXXXXXXXXXXX\n${error.message}')));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bannerAdz.dispose();
    interstitialAdz.dispose();
  }
}
