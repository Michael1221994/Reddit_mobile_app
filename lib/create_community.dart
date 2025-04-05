import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/bottomsheet.dart';
import 'Custom_Widgets/dropdown_widgets.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});
  

  
  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}


 final List<Map<String, dynamic>> dropdownItems = [
    {
      "title": "Public",
      "description": "Anyone can view, post, and comment to the community",
      "icon": Icons.public,
      "value": "Public"
    },
    {
      "title": "Restricted",
      "description": "Anyone can view, but only approved users can post",
      "icon": Icons.check_circle_outline,
      "value": "Restricted"
    },
  
    {
      "title": "Private",
      "description": "Only approved users can view and submit ",
      "icon": Icons.lock_outline,
      "value": "Private"
    },
  ];

class _CreateCommunityState extends State<CreateCommunity> {
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => bottomsheet());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController Community_name = TextEditingController();
    String  selectedvalue= "Public" ;
    return Scaffold(
      appBar: AppBar(title: Text("Create a Community"),
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                Text("Create a Community"),
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  
                  child: TextField(
                    decoration: InputDecoration(labelText: "r/Community_name", floatingLabelBehavior: FloatingLabelBehavior.never, border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)), labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,),),
                    controller: Community_name,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  //decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(14), color: Colors.white),
                  child: GestureDetector(
                    onTap: _openBottomSheet,
                    //foregroundColor: Colors.black,
                    
                    child: Row(
                      children: [
                        Text(selectedvalue),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.03,
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    ),
                ),
                /*DropdownButton(
                  value: selectedvalue,
                  hint: Text(selectedvalue),
                  isExpanded: true,
                 items: dropdownItems.map((item) {
                  return DropdownMenuItem<String>(
                    value: item["value"],
                      child: ListTile(
                        leading: Icon(item["icon"]),
                        title: Text(item["title"]),
                        subtitle: Text(item["description"]),
                        
                    
                    ),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    selectedvalue=newvalue!;
                  });
                }
                  )*/
                ]
                ),
            )
          ],
        ),
      ),
    );
  }
}