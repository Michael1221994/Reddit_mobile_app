import 'package:flutter/material.dart';

class Poll1 extends StatefulWidget {
    final Function(Widget)? onSave; 

  const Poll1({Key? key, this.onSave}) : super(key: key);
  @override
  State<Poll1> createState() => _PollState();
}

class _PollState extends State<Poll1> {
  TextEditingController poll1 = TextEditingController();
  TextEditingController poll2 = TextEditingController();
  Map<int, TextEditingController> textControllers = {
  0: TextEditingController(), // Controller for the first input field
  1: TextEditingController(), // Controller for the second input field
  2: TextEditingController(), // Controller for the third input field
  3: TextEditingController(), // Controller for the fourth input field
};

  List<TextEditingController> textList = []; // List for poll option controllers
  List<int> pollIndices = []; // Track added polls
  int nextPollIndex = 0;
  int counter = 2; // Already have 2 polls

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel_outlined),
        ),
        
      ),
      body: Column(
        children: [
          TextField(
            controller: poll1,
            decoration: InputDecoration(labelText: "Poll 1"),
          ),
          TextField(
            controller: poll2,
            decoration: InputDecoration(labelText: "Poll 2"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pollIndices.length,
              itemBuilder: (context, index) {
                return buildPollRow(index);

              },
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              onTap: addPoll,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                 children: 
                 [
                  Icon(Icons.add),
                  SizedBox(width: 5,),
                  Text("Add Poll")
                  ],
                
                ),
            
            ),
          ),
        ],
      ),
    );
  }

  void addPoll() {
  if (counter < 6) {
    setState(() {
      int newIndex = textControllers.length;
      textControllers[newIndex] = TextEditingController(); // Dynamically add a new controller to the map
      pollIndices.add(newIndex); // Use newIndex to track added polls correctly
      nextPollIndex++;
      counter++;
    });
  }
}

bool validdata(){
  if(poll1.text.isEmpty || poll2.text.isEmpty){
    return false;
  }
  else{
    return true;
  }
}

void saveandclose(){
  if(validdata()){
    widget.onSave?.call(this.widget);
  }
 
}

Widget buildPollRow(int index) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: textControllers[pollIndices[index]], // Correctly reference the controller based on current index
          decoration: InputDecoration(labelText: "Other poll"),
        ),
      ),
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () => removePoll(index),
      ),
    ],
  );
}

void removePoll(int index) {
  setState(() {
    int keyToRemove = pollIndices[index];
    textControllers[keyToRemove]?.dispose(); // Dispose of the controller
    textControllers.remove(keyToRemove); // Remove controller from the map
    pollIndices.removeAt(index); // Adjust indices list accordingly
    counter--;
  });
}

  @override
  void dispose() {
    poll1.dispose();
    poll2.dispose();
    for (var controller in textList) {
      controller.dispose();
    }
    super.dispose();
  }
}
