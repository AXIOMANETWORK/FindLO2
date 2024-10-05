import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_trabajo/pages/login/login_page.dart';

class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Splash> with SingleTickerProviderStateMixin {
  var _visible = true;

  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushNamed("login");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Color.fromARGB(255,255, 65, 81),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Padding(padding: EdgeInsets.only(bottom: 30.0),child:new Image.asset('assets/powered_by.png',height: 25.0,fit: BoxFit.scaleDown,))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/icon-rojo.png'
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
