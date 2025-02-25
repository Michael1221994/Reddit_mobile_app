import 'package:flutter/material.dart';


class container extends StatefulWidget {
  final String? title;
  final String? text;
  final String post_type;
  final String number_of_comments;
  final String number_of_upvotes;
  final String number_of_downvotes;
  final List<String> flaires;
  final String? image_name;
  final String? video_name;
  final String? link;

  const container({super.key, 
      this.title,
      this.text,
      required this.post_type,
      required this.number_of_comments,
      required this.number_of_upvotes,
      required this.number_of_downvotes,
      required this.flaires,
      this.image_name,
      this.video_name,
      this.link
    });

  @override
  State<container> createState() => _containerState();
}

class _containerState extends State<container> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        
        decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(10), ),
        child: Column(
          children: [
            Text (widget.title!),
            Container(
              decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Image(image: AssetImage(widget.image_name!))
              ),
            Text(widget.text!),
            Row(
              children: [
                Column(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_upward_outlined ) ),
                    Text(widget.number_of_upvotes)
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_downward_outlined ) ),
                    Text(widget.number_of_downvotes)
                  ],
                )
              ],
            )
              
              
            
          ],
        ),
      )     
      

    );
  }
}