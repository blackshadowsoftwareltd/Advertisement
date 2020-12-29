import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Second Page'),
        // ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ))));
  }
}
