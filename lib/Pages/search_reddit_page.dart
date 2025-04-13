import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/search_textfield.dart';


class searchReddit extends StatefulWidget {
  const searchReddit({super.key});

  @override
  State<searchReddit> createState() => _searchRedditState();
}

class _searchRedditState extends State<searchReddit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
         actions: [
             SearchTextfield(),
         ],
      
      ),
      //body: ListView.builder(itemBuilder: ),
        body: SingleChildScrollView(
          child:  Padding(
          padding: EdgeInsets.all(12.0),
          child: Column()// where all the things they search for show up 
              ),
        )
    );
  }
}