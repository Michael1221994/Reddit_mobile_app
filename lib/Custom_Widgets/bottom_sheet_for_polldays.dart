import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/days_limit.dart';

class number_of_days extends StatefulWidget {
  late String? initialSelection;
   number_of_days({
    super.key,
    required this.initialSelection
    });

  @override
  State<number_of_days> createState() => _number_of_daysState();
}

class _number_of_daysState extends State<number_of_days> {

  List<String> dayOptions = ['1', '2','3','4','5', '6', '7'];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: dayOptions.map((option){//this awesome howw ?
          return daysLimit(
            value: option, 
            groupValue: widget.initialSelection, 
            onChanged: (val){
              setState(() {
                widget.initialSelection=val;
              });
            });
        }).toList()
      ),

    );
  }
   
    }
   
    
