import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Pages/wrapper.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => wrapper()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 78, 2),
      body: Center(
        child: Container(
          
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.height*0.25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.7), // Shadow color with some transparency
                spreadRadius: 10,  // Spread radius
                blurRadius: 13,   // Blur radius
                offset: Offset(0, 3),  // changes position of shadow
                ),
              ],
            ),
          child: Image (
            image: AssetImage('lib/assets/reddit.png'),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.height*0.25,
            
            ),
        ),
      ),
    );
  }
}