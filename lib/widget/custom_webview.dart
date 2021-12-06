import 'package:dosdownloader/controller/custom_webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomWebViewCTRL webViewCtrl = Get.put(CustomWebViewCTRL());
    print(webViewCtrl.initialUrl.toString());
    webViewCtrl.enableHybridComposition();
    return WillPopScope(
        onWillPop: () async {
          if (await webViewCtrl.controller!.canGoBack()) {
            webViewCtrl.controller!.goBack();
          }
          return false;
        },
        child: Obx(
          () => WebView(
            initialUrl: webViewCtrl.initialUrl.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              webViewCtrl.onWebviewCreated(controller);
            },
            onProgress: (progress) => webViewCtrl.onProgress(progress),
          ),
        ));
  }
}
