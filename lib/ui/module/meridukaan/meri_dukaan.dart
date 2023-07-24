import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mcsofttech/ui/base/page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../constants/Constant.dart';
import '../../../services/navigator.dart';

class MeriDukaan extends AppPageWithAppBar {
  late WebViewController _webviewController;
  static const String routeName = "/meriDukaan";

  MeriDukaan({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String title, String mereDukanLink) {
    return navigateTo<bool>(routeName,
        currentPageTitle: title, arguments: {"mereDukanLink": mereDukanLink});
  }

  @override
  Widget get body {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: SizedBox(
          height: screenHeight,
          child: WebView(

            onWebViewCreated: (WebViewController webViewController) {
              _webviewController = webViewController;
              _webviewController.canGoBack();
              _webviewController.canGoForward();
            },
            initialUrl: "${arguments['mereDukanLink']}",
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
