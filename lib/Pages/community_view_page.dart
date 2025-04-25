import 'package:flutter/material.dart';

class communityView extends StatelessWidget {
  final String community_name;
  final String community_description;
  final bool adult;
  final List<String> members;

  const communityView({
    super.key,
    required this.community_name,
    required this.community_description,
    required this.adult,
    required this.members
    });

  @override
  Widget build(BuildContext context) {
    String adult="";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 49, 230),
        actions: [
          Text(community_name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
          Text(community_description, style: const TextStyle(color: Colors.white), ),
          Text(adult, style: const TextStyle(color:  Colors.white),),
        ],
      ),
    );
  }
}