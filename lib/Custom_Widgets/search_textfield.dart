import 'package:flutter/material.dart';


class SearchTextfield extends StatefulWidget {
  //final TextEditingController searchReddit;
  const SearchTextfield({
    super.key,
    //required this.searchReddit,
    });

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
   TextEditingController searchReddit= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Row(
            children: [
              const Padding(
                padding:  EdgeInsets.only(left:2.0),
                child:  Icon(Icons.search),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.02,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextField(
                    controller:searchReddit,
                    decoration:const  InputDecoration(
                      
                      labelText: 'search Reddit', floatingLabelBehavior: FloatingLabelBehavior.never, hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {
                  searchReddit.clear();
          
                
              }, icon: const Icon(Icons.cancel))
            ],
          ),
        ),
      ),
    );
  }
}