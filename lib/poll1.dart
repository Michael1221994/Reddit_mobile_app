import 'package:flutter/material.dart';

class Poll1 extends StatefulWidget {
  const Poll1({Key? key}) : super(key: key);

  @override
  State<Poll1> createState() => _PollState();
}

class _PollState extends State<Poll1> {
  TextEditingController poll1=TextEditingController();
  TextEditingController poll2=TextEditingController();
  Map<int, TextEditingController> controllers = {};
  List<int> pollIndices = [];
  int nextPollIndex = 1;
  int counter=2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll ends"),
      ),
      body: Column(
        children: [
          TextField(
              controller: poll1,
              decoration: InputDecoration(
                labelText: "Poll1",
              ),
            ),
            TextField(
              controller: poll2,
              decoration: InputDecoration(
                labelText: "Poll2",
              ),
            ),
          Expanded(
            child: ListView(
              children: pollIndices.map((index) => buildPollRow(counter)).toList(),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              addPoll();
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget buildPollRow(int index) {
    var controller = controllers.putIfAbsent(index, () => TextEditingController());

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Poll $index",
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => removePoll(index),
        ),
      ],
    );
  }

  void addPoll() {
    if(counter<=5){
      setState(() {
      pollIndices.add(nextPollIndex);
      nextPollIndex++;
      counter++;
    });
    }
    
  }

  void removePoll(int index) {
    setState(() {
      pollIndices.remove(index);
      controllers[index]?.dispose(); // Dispose the controller
      controllers.remove(index);
      counter--;
    });
  }
}
