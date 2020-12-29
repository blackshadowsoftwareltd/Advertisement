import 'package:AdMob/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  /// initialization
  InterstitialAd myInterstitial;
  BannerAd myBanner;

  void initState() {
    // TODO: implement initState
    super.initState();

    ///
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.male,
      // or MobileAdGender.female, MobileAdGender.unknown
      /// testDevices: for Emulator device. otherwise Remove it
      testDevices: <String>[],
    );

    /// calling in it state
    // interstitialInItState();

    /// BannerAd
    myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    _bannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admob'),
      ),
      body: Center(
        child: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () async {
            bool isTrue = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondPage()));
            if (isTrue == true) {
              print('>>>>>>$isTrue');
              loadInterstitial();
            }
          },
        ),
      ),
    );
  }

  _bannerAd() {
    /// calling Banner ads
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 0.0 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 10.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  loadInterstitial() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.male,
      // or MobileAdGender.female, MobileAdGender.unknown
      /// testDevices: for Emulator device. otherwise Remove it
      testDevices: <String>[],
    );

    ///  InterstitialAd
    myInterstitial = InterstitialAd(
      /// adUnitId: original Ad Unit Id
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    _interstitialAd();
  }

  _interstitialAd() {
    /// calling Interstitial ads
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }
}
