import 'package:flutter/material.dart';
import 'package:reddit_attempt2/login.dart';

class Communities extends StatefulWidget {
  const Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   
      body: SingleChildScrollView(
              child:  Center(child: Text("Communities")),

      ),
    );
  }
}