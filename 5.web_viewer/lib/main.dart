import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WebviewProvier>(
      create: (_) => WebviewProvier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Web Viewer',
        theme: ThemeData.dark(),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WebViewController controller =
        context.read<WebviewProvier>().webViewController;
    return Scaffold(
      appBar: _appBar(),
      //
      body: WebViewWidget(
        controller: controller,
      ),
      //
      bottomNavigationBar: _bottomAppBar(controller),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Web Viewer'),
    );
  }

  BottomAppBar _bottomAppBar(controller) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: controller.goBack,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: controller.goForward,
          ),
        ],
      ),
    );
  }
}
