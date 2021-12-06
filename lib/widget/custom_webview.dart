import 'package:dosdownloader/controller/custom_webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomWebViewCTRL>(builder: (ctrl) {
      return WillPopScope(
        onWillPop: () async {
          if (await ctrl.controller!.canGoBack()) {
            ctrl.controller!.goBack();
          }
          return false;
        },
        child: WebView(
          initialUrl: ctrl.initialUrl.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            ctrl.onWebviewCreated(controller);
          },
          onWebResourceError: (error) {
            ctrl.onWebResourceError(error);
          },
          zoomEnabled: false,
          onProgress: (progress) => ctrl.onProgress(progress),
        ),
      );
    });
  }
}
