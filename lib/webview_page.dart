import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_with_navigator/webview_view.dart';


class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  
  late final WebViewController controller;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()..loadRequest(
      Uri.parse('https://google.com')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web View"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed:() async{
                final messenger = ScaffoldMessenger.of(context);
                if(await controller.canGoBack()){
                  await controller.goBack();
                } else {
                  messenger.showSnackBar(
                    SnackBar(content: Text("No Back History Found"))
                  );

                  return;
                }
              },), 
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed:() async{
                final messenger = ScaffoldMessenger.of(context);
                if(await controller.canGoForward()){
                  await controller.goForward();
                } else {
                  messenger.showSnackBar(
                    SnackBar(content: Text("No Forward History Found"))
                  );

                  return;
                }
              },), 
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: (){
                  controller.reload();
                },
              )
            ],
          )
        ],
      ),

      body: WebviewView(controller: controller,),

      
    );
  }
}