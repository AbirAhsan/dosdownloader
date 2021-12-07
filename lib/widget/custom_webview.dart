import 'package:dosdownloader/controller/custom_webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("object");
    return GetBuilder<CustomWebViewCTRL>(builder: (ctrl) {
      // print("object");
      return WillPopScope(
        onWillPop: () async {
          if (await ctrl.webViewController!.canGoBack()) {
            ctrl.webViewController!
                .goBack()
                .then((value) => ctrl.getCurrentUrl());
          }
          ctrl.getCurrentUrl();
          return false;
        },
        child: InAppWebView(
          key: ctrl.webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse("${ctrl.initialUrl}")),
          initialOptions: ctrl.options,
          onWebViewCreated: (controller) {
            ctrl.setWebViewController(controller);
          },
          onLoadStart: (controller, url) {
            ctrl.getCurrentUrl();
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          onLoadStop: (controller, url) {
            ctrl.getCurrentUrl();
          },
          onProgressChanged: (controller, progress) {
            ctrl.getCurrentUrl();
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            ctrl.getCurrentUrl();
          },
          onConsoleMessage: (controller, consoleMessage) {
            ctrl.getCurrentUrl();
            print("Console message is $consoleMessage");
          },
        ),
      );
    });
  }
}
