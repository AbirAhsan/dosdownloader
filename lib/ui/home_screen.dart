import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DOS Downloader"),
      ),
      drawer: Drawer(
        child: SizedBox(
          child: ListView(),
        ),
      ),
    );
  }
}
