import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/dropdown_widgets.dart';

class bottomsheet extends StatefulWidget {
  const bottomsheet({super.key});

  @override
  State<bottomsheet> createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
    int isSelected=0;

  @override

 
  Widget build(BuildContext context) {
      List<custom_Dropdown_Item>Items =[
       custom_Dropdown_Item(title: "Public", description: "Anyone can view, post, and comment to the community", icon: Icons.public),
       custom_Dropdown_Item(title: "Restricted", description: "Anyone can view, but only approved users can post", icon: Icons.check_circle_outline),
       custom_Dropdown_Item(title: "Private", description: "Only approved users can view and submit", icon: Icons.lock_outline)

  ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            GestureDetector(child: Items[0], onTap: () => setState(() {
              isSelected=0;
              print(isSelected);
              Navigator.pop(context);
            }),),
            const SizedBox(height: 10,),
            GestureDetector(child: Items[1], onTap: () => setState(() {
              isSelected=1;
              print(isSelected);
              Navigator.pop(context);
            }),),
            const SizedBox(height: 10,),
            GestureDetector(child: Items[2], onTap: () => setState(() {
              isSelected=2;
              print(isSelected);
              Navigator.pop(context);
            }),)
          ],
          
        ),
      ),
    );
  }
}