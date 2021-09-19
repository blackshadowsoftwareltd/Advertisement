import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdScreen extends StatefulWidget {
  @override
  _NativeAdScreenState createState() => _NativeAdScreenState();
}

class _NativeAdScreenState extends State<NativeAdScreen> {
  late NativeAd nativeAd;
  bool isLoaded = false;

  static final adIndex = 4;
  List<Object> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Native Ad')),
      body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            if (isLoaded && index == adIndex) {
              return Container(
                  height: 72,
                  alignment: Alignment.center,
                  child: AdWidget(ad: nativeAd));
            } else {
              final item = itemList[getDestinationItemIdex(index)] as String;
              return Container(
                height: 75,
                child: Text(item),
              );
            }
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nativeAd = NativeAd(
        adUnitId: NativeAd.testAdUnitId,
        factoryId: 'listTile',
        listener: NativeAdListener(
            onAdLoaded: (_) => setState(() => isLoaded = true),
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
              print('XXXXXXXX \n ${error.message}');
            }),
        request: AdRequest());

    ///
    nativeAd.load();

    ///
    for (int i = 1; i <= 20; i++) {
      itemList.add('Index $i');
    }
  }

  ///
  @override
  void dispose() {
    super.dispose();
    nativeAd.dispose();
  }

  ///
  int getDestinationItemIdex(int index) {
    if (index >= adIndex && isLoaded) return index - 1;
    return index;
  }
}
