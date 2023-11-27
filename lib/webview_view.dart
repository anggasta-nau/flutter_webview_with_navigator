

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {
  const WebviewView({super.key, required this.controller});


  final WebViewController controller;

  @override
  State<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  
  var loadingPercentage = 0;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url){
          setState(() {
            loadingPercentage =0;
          });
        },
        onProgress: (progress){
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ),
    )..setJavaScriptMode(JavaScriptMode.unrestricted)..addJavaScriptChannel("SnackBar", onMessageReceived: (message){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
    });
  }
  
  
  @override
Widget build(BuildContext context) {
  return Stack(
    children: [
      WebViewWidget(controller: widget.controller),
      if (loadingPercentage < 100)
        Center(
          child: CircularProgressIndicator(
            // value: loadingPercentage / 100.0,
          ),
        ),
    ],
  );
}

}