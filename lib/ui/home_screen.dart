import 'package:dosdownloader/controller/custom_webview_controller.dart';
import 'package:dosdownloader/widget/custom_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final CustomWebViewCTRL webViewCtrl = Get.put(CustomWebViewCTRL());

    return Scaffold(
        appBar: AppBar(
          title: const Text("DOS Downloader"),
          // actions: [
          //   IconButton(
          //       onPressed: () async {
          //         if (await webViewCtrl.controller!.canGoBack()) {
          //           webViewCtrl.controller!.goBack();
          //         }
          //       },
          //       icon: const Icon(Icons.ac_unit_outlined))
          // ],
          bottom: PreferredSize(
            child: Obx(() => Visibility(
                  visible: webViewCtrl.progress.toDouble() != 1.0,
                  child: LinearProgressIndicator(
                    value: webViewCtrl.progress.toDouble(),
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )),
            preferredSize: Size(_width, 10),
          ),
        ),
        // drawer: Drawer(
        //   child: SizedBox(
        //     child: ListView(),
        //   ),
        // ),
        body: const CustomWebView(),
        floatingActionButton: Obx(() => Visibility(
              visible: webViewCtrl.haveCurrentUrl.toString() !=
                  "https://m.youtube.com/",
              child: FloatingActionButton(
                onPressed: () {
                  webViewCtrl.downloadVideo();
                  // webViewCtrl.controller!.currentUrl().then((value) {
                  //   print(value);
                  // });
                  // webViewCtrl.getCurrentUrl();
                  print(webViewCtrl.haveCurrentUrl);
                },
                child: const Icon(Icons.download),
              ),
            )));
  }
}
