import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      title: "BTK Akademi",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith("https://www.btkakademi.gov.tr/") ||
              request.url.startsWith("https://giris.turkiye.gov.tr/")) {
            return NavigationDecision.navigate;
          } else {
            launchUrl(Uri.parse(request.url));
            return NavigationDecision.prevent;
          }
        },
      ),
    )
    ..loadRequest(Uri.parse("https://www.btkakademi.gov.tr/portal"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SizedBox(
                width: double.infinity,
                child: WebViewWidget(
                  controller: _controller,
                ),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: WebViewWidget(
                  controller: _controller,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
