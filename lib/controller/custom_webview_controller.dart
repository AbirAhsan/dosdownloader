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
    getCurrentUrl();
    super.onInit();
  }

  enableHybridComposition() {
    print("enableHybridComposition");
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void getCurrentUrl() async {
    print("value");

    String? st = await controller!.currentUrl();
    print(st);
    haveCurrentUrl.value = st!;
    print(haveCurrentUrl);
  }

  changeInitialUrl(String url) {
    initialUrl.value = url;
  }

  onWebviewCreated(ctrl) {
    controller = ctrl;
    getCurrentUrl();
  }

  onProgress(pro) {
    progress.value = pro / 100;
  }

  onWebResourceError(WebResourceError error) {
    print("Something Went to Wrong : ${error.errorCode}");
  }
}
