import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/bottomsheet.dart';
import '../Custom_Widgets/dropdown_widgets.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});
  

  
  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}


 

class _CreateCommunityState extends State<CreateCommunity> {
  String selectedType= "Public";
  bool adult = false;
  TextEditingController Community_name = TextEditingController();
  String  selectedvalue= "Public" ;

  void adultselected(int index){
    setState(() {
      adult=!adult;
    });
  }
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => bottomsheet(
        initialSelection: selectedType,
        onTypeSelected: (newType){
          setState(() {
            selectedType=newType;
          });
          print(selectedType);
        },

      ));
  }

  @override
  Widget build(BuildContext context) {
    
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
                const Text("Create a Community"),
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  
                  child: TextField(
                    decoration: InputDecoration(labelText: "r/Community_name", floatingLabelBehavior: FloatingLabelBehavior.never, border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)), labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,),),
                    controller: Community_name,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: GestureDetector(
                    onTap: _openBottomSheet,
                    
                    child: Row(
                      children: [
                        Text(selectedType),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.03,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    ),
                ),
                 SizedBox(
                  height:MediaQuery.of(context).size.height*0.04,
                ),
                Row(
                  children: [
                    Text("18+ Community"),
                    SizedBox(width: MediaQuery.of(context).size.width*0.5,),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        value: adult,
                        onChanged: (value) {
                          setState(() {
                            adult = value;
                            print(adult);
                          });
                        },
                        activeColor: Colors.blue, // Color when ON
                        activeTrackColor: Colors.blue[200], // Track color when ON
                      ),
                    )
                   /* ToggleButtons(children: [Icon(Icons.toggle)], isSelected: [adult],
                    onPressed: (int index) => {setState(() {
                                adult=!adult;
                              })},
                    )*/
                  ],
                ),
                 SizedBox(
                  height:MediaQuery.of(context).size.height*0.05,
                ),
                ElevatedButton(
                  onPressed: Community_name.text.isEmpty ?null : (){} , 
                  child: Text("Create Community"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Community_name.text.isEmpty ? Colors.grey: Colors.deepPurple ,
                    foregroundColor: Colors.white
                  ),
                  )
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