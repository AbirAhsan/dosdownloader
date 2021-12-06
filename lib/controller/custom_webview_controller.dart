import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewCTRL extends GetxController {
  RxString initialUrl = "https://m.youtube.com".obs;
  WebViewController? controller;

  RxDouble progress = 0.0.obs;

  enableHybridComposition() {
    print("enableHybridComposition");
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  changeInitialUrl(String url) {
    initialUrl.value = url;
  }

  onWebviewCreated(ctrl) {
    controller = ctrl;
  }

  onProgress(pro) {
    progress.value = pro / 100;
  }
}
