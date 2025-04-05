import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/dropdown_widgets.dart';

class bottomsheet extends StatefulWidget {
  final Function(String) onTypeSelected;
  final String initialSelection;
  const bottomsheet({
    super.key,
    required this.onTypeSelected,
    required this.initialSelection,
    
    });

  @override
  State<bottomsheet> createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
    late String isSelected;

  @override
  void initState(){
      super.initState();
      isSelected= widget.initialSelection;
  }

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
              isSelected="Public";
              widget.onTypeSelected("Public");
              print(0);
              Navigator.pop(context);
            }),),
            const SizedBox(height: 10,),
            GestureDetector(child: Items[1], onTap: () => setState(() {
              isSelected="Restricted";
              widget.onTypeSelected("Restricted");
              print(1);
              Navigator.pop(context);
            }),),
            const SizedBox(height: 10,),
            GestureDetector(child: Items[2], onTap: () => setState(() {
              isSelected= "Private";
              widget.onTypeSelected("Private");

              print(2);
              Navigator.pop(context);
            }),)
          ],
          
        ),
      ),
    );
  }
}