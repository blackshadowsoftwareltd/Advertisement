import 'dart:io';

class AdzId {
  static String bannerId() {
    if (Platform.isAndroid)
      return 'ca-app-pub-3940256099942544/6300978111';
    else if (Platform.isIOS)
      return 'ca-app-pub-3940256099942544/2934735716';
    else
      throw UnsupportedError('Platform error');
  }

  static String interstitialId() {
    if (Platform.isAndroid)
      return 'ca-app-pub-3940256099942544/1033173712';
    else if (Platform.isIOS)
      return 'ca-app-pub-3940256099942544/4411468910';
    else
      throw UnsupportedError('Platform error');
  }
}
