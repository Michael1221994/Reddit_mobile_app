import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/bottom_sheet_for_polldays.dart';
import 'package:reddit_attempt2/Custom_Widgets/poll_row.dart';

class BuildPoll extends StatefulWidget {
  final TextEditingController poll1 ;
  final TextEditingController poll2;
  void Function()? removePoll;

   BuildPoll({
    super.key,
    required this.poll1,
    required this.poll2,
    required this.removePoll,
    });

  Map<int, TextEditingController> textControllers = {
    0: TextEditingController(), // Controller for the first input field
    1: TextEditingController(), // Controller for the second input field
    2: TextEditingController(), // Controller for the third input field
    3: TextEditingController(), // Controller for the fourth input field
  };

  int counter=0;

  List<Widget> newpoll= [];

  

  @override
  State<BuildPoll> createState() => _BuildPollState();
}

class _BuildPollState extends State<BuildPoll> {

  String selected="2";

   void _openBottomSheet() {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => number_of_days(
          initialSelection: selected,
          onTypeSelected: (newType){
            setState(() {
              selected=newType!;
            });
            print(selected);
          },

      ));
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    
    decoration: BoxDecoration(border: Border.all(), color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
    width: MediaQuery.of(context).size.width*0.8,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: ListView(
          shrinkWrap: true,
          
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: _openBottomSheet,
                    
                    child: Row(
                      children: [
                        Text("$selected days"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.03,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    ),
                IconButton(onPressed: widget.removePoll, icon: const Icon(Icons.cancel_outlined)),
              ],
            ),
            TextField(
              controller: widget.poll1,
              decoration: const InputDecoration(labelText: "Poll 1"),
            ),
            TextField(
              controller: widget.poll2,
              decoration: const InputDecoration(labelText: "Poll 2"),
            ),
            const SizedBox(
              height: 10,
            ),
           
      
          Column(
                  children: [Wrap(
                    children:widget.newpoll,
                    ),]
                ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: addPollRow,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5),
                    Text("Add Poll"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



void addPollRow(){
  if(widget.counter<4){
    setState(() {
      widget.newpoll.add(PollRow(textcontroller: widget.textControllers[widget.counter]!, removePolls: () => removePolls(), counter: widget.counter,));
      print(widget.counter);
      widget.counter++;
      
    });
  }
}

void removePolls(){
  setState(() {
    widget.newpoll.removeAt(widget.counter-1);
    widget.counter--;
    print(widget.counter);
  });
}


}