import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomWebViewCTRL extends GetxController {
  RxString initialUrl = "https://m.youtube.com".obs;

  RxString haveCurrentUrl = "".obs;
  RxDouble progress = 0.0.obs;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;

  final TextEditingController urlController = TextEditingController();

  @override
  void onInit() {
    enableHybridComposition();

    super.onInit();
  }

  enableHybridComposition() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        serviceWorkerController.serviceWorkerClient =
            AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        );
      }
    }
  }

  setWebViewController(ctrl) {
    webViewController = ctrl;
  }

  void getCurrentUrl() async {
    print("The value is ");
    webViewController!.getUrl().then((value) {
      haveCurrentUrl.value = value.toString();
    });

    print("Current URL $haveCurrentUrl");
  }

  changeInitialUrl(String url) {
    initialUrl.value = url;
  }

  // onWebviewCreated(ctrl) {
  //   controller = ctrl;
  //   getCurrentUrl();
  //   // controller.evaluateJavascript(javascriptString)
  // }

  // onProgress(pro) {
  //   progress.value = pro / 100;
  // }

  // onWebResourceError(WebResourceError error) {
  //   print("Something Went to Wrong : ${error.errorCode}");
  // }

  Future<void> downloadVideo() async {
    String? title = await webViewController!.getTitle();

    Uri? url = await webViewController!.getUrl();
    print("$url");
    // List<MetaTag> tag = await webViewController!.getMetaTags();

    final result = await FlutterYoutubeDownloader.downloadVideo(
        "${url.toString()}+&&html5=1", "Hello", 18);
    print(result);
  }
}
