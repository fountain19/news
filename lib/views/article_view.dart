import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blocUrl;
  ArticleView({this.blocUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer=
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'News'.toUpperCase(),style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
        actions: [
          Opacity(
              opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save),
          ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blocUrl,
          onWebViewCreated: ((WebViewController webviewCOntroller){
            _completer.complete(webviewCOntroller);
          }),
        ),
      ),
    );
  }
}
