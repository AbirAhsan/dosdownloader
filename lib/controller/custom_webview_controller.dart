import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewCTRL extends GetxController {
  RxString initialUrl = "https://m.youtube.com".obs;
  WebViewController? controller;
  RxString haveCurrentUrl = "".obs;
  RxDouble progress = 0.0.obs;
  @override
  void onInit() {
    enableHybridComposition();

    super.onInit();
  }

  enableHybridComposition() {
    print("enableHybridComposition");
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void getCurrentUrl() async {
    print("The value is ");

    String? st = await controller!.currentUrl();

    haveCurrentUrl.value = st!;
    print("Current URL $haveCurrentUrl");
  }

  changeInitialUrl(String url) {
    initialUrl.value = url;
  }

  onWebviewCreated(ctrl) {
    controller = ctrl;
    getCurrentUrl();
    // controller.evaluateJavascript(javascriptString)
  }

  onProgress(pro) {
    progress.value = pro / 100;
  }

  onWebResourceError(WebResourceError error) {
    print("Something Went to Wrong : ${error.errorCode}");
  }
}
