import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/bottomsheet.dart';
import 'package:reddit_attempt2/Pages/createPost.dart';
import 'package:reddit_attempt2/Services/firestore.dart';
import 'package:reddit_attempt2/firebase_auth_implementation/firebase_auth.dart';

class CreateCommunity extends StatefulWidget {
  final String currentUserID; 
  CreateCommunity({
    super.key,
    required this.currentUserID
  });
  
final FirebaseFirestore firestore= FirebaseFirestore.instance;
late  String selectedType= "Public";
bool adult = false;
final TextEditingController community_name = TextEditingController();
  //chat and auth services
  final FirebaseAuthImplementation auth=FirebaseAuthImplementation();
  final FirestoreService firestoreservice= FirestoreService();

  void createCommunity (context) async {
    await firestoreservice.createCommunity(community_name.text, selectedType, currentUserID, adult);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Createpost()));
  }


  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}


 

class _CreateCommunityState extends State<CreateCommunity> {
 

  

  void adultselected(int index){
    setState(() {
      widget.adult=!widget.adult;
      print(widget.adult);
    });
  }
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => bottomsheet(
        initialSelection: widget.selectedType,
        onTypeSelected: (newType){
          setState(() {
            widget.selectedType=newType;
          });
          print(widget.selectedType);
        },

      ));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Create a Community"),
      leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),),
      
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
                    decoration: InputDecoration(labelText: "r/Community_name", hintStyle: TextStyle(color: const Color.fromARGB(255, 207, 206, 206)) , floatingLabelBehavior: FloatingLabelBehavior.never, border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)), labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,),),
                    controller: widget.community_name,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: GestureDetector(
                    onTap: _openBottomSheet,
                    
                    child: Row(
                      children: [
                        Text(widget.selectedType),
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
                    const Text("18+ Community"),
                    SizedBox(width: MediaQuery.of(context).size.width*0.5,),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        value: widget.adult,
                        onChanged: (value) {
                          setState(() {
                            widget.adult = value;
                            print(widget.adult);
                          });
                        },
                        activeColor: Colors.blue, // Color when ON
                        activeTrackColor: Colors.blue[200], // Track color when ON
                      ),
                    )
                   
                  ],
                ),
                 SizedBox(
                  height:MediaQuery.of(context).size.height*0.05,
                ),
                ElevatedButton(
                  onPressed: () => widget.createCommunity(context), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.community_name.text.isEmpty ? Colors.grey: Colors.deepPurple ,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Create Community"),

                  )
                
                ]
                ),
            )
          ],
        ),
      ),
    );
  }
}