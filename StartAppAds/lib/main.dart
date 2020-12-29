import 'dart:async';

import 'package:flutter/material.dart';
import 'package:startapp_sdk_flutter/startapp_sdk_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
  }

// ads
  Future<void> initApp() async {
    Startapp.instance.initialize(accountId: '110709564', appId: '209636944');
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    WebViewController _webViewController;

    return Scaffold(
      appBar: AppBar(title: Text('Google News'),
        actions: [NavigationControls(_controller.future)],
      ),
      body: Container(
        child: Builder(
          builder: (BuildContext context) {
            return WebView(
              initialUrl:
                  'https://news.google.com/topstories?hl=en-US&gl=US&ceid=US:en',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webController) {
                _controller.complete(webController);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        width: double.infinity,
        color: Colors.transparent,
        child: StartappBanner(
          // listener: handleEvent,
          adSize: StartappBannerSize.BANNER,
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapShot) {
        final bool webViewReady =
            snapShot.connectionState == ConnectionState.done;
        final WebViewController controller = snapShot.data;
        return Row(
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoBack()) {
                          controller.goBack();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Loading..........')));
                        } else {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('No Back history Item')));
                        }
                      }),
            IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await controller.canGoForward()) {
                          controller.goForward();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Loading..........')));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('No Forward history Item')));
                        }
                      }),
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        controller.reload();
                      })
          ],
        );
      },
    );
  }
}

// Container(
//   alignment: Alignment.bottomCenter,
//   child: Container(
//     alignment: Alignment.center,
//     height: 55,
//     width: double.infinity,
//     color: Colors.transparent,
//     child: StartappBanner(
//       listener: handleEvent,
//       adSize: StartappBannerSize.BANNER,
//     ),
//   ),
// ),

// ),
//   bottomNavigationBar: Container(
//   height: 100,
//   width: double.infinity,
//   color: Colors.blue,
//   child: StartappBanner(
//     listener: handleEvent,
//     adSize: StartappBannerSize.BANNER,
//   ),
// ),
// }

// void handleEvent(StartappEvent event) {
//   switch (event) {
//     case StartappEvent.onClick:
//       print('Received: onClick!');
//       break;
//     case StartappEvent.onReceiveAd:
//       print('Received: onReceiveAd');
//       break;
//     case StartappEvent.onImpression:
//       print('Received: onImpression');
//       break;
//     case StartappEvent.onFailedToReceiveAd:
//       print('Received: onFailedToReceiveAd');
//       break;
//     default:
//   }
