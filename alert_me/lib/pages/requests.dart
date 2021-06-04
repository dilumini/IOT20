import 'package:flutter/material.dart';

class request extends StatefulWidget {
  @override
  _requestState createState() => _requestState();
}

class _requestState extends State<request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Image.asset(
            "images/titile.png",
            height: 150.0,
            width: 151.0,
          )),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
