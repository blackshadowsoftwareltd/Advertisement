import 'dart:math';

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  int randomNumber=0;

  void initState() {
    // TODO: implement initState
    super.initState();
    Random random = new Random();
    randomNumber = random.nextInt(2);
  }

  @override
  Widget build(BuildContext context) {
    print('..........$randomNumber');
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        height: 50,
        margin: EdgeInsets.all(10),
        child: FlatButton(
          color: Colors.blue,
          child: Text(
            'Back to Home Screen',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context, randomNumber),
        ),
      ),
    );
  }
}
