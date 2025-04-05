import 'package:flutter/material.dart';

class custom_Dropdown_Item extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  late final  bool isSelected;

   custom_Dropdown_Item({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isSelected=false,
    });

  @override
  State<custom_Dropdown_Item> createState() => _custom_Dropdown_ItemState();
}

class _custom_Dropdown_ItemState extends State<custom_Dropdown_Item> {
void selected (){
  setState(() {
    widget.isSelected= true;
    print(widget.isSelected);

  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      
        child: Row(
          children: [
            Icon(widget.icon, size:20),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Text(widget.description, style: TextStyle(),)),
                const SizedBox(height: 10,)
              ],
            )
        
          ],
          ),
  
    );
  }
}