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
    return  Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Row(
        children: [
          const Icon(Icons.search),
          TextField(
            controller:searchReddit,
            decoration: const InputDecoration(
              
              labelText: 'search Reddit', floatingLabelBehavior: FloatingLabelBehavior.never, hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          IconButton(onPressed: () {
            setState(() {
              searchReddit.dispose();
      
            });
          }, icon: const Icon(Icons.cancel))
        ],
      ),
    );
  }
}