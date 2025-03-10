import 'package:flutter/material.dart';

class Poll1 extends StatefulWidget {
  const Poll1({Key? key}) : super(key: key);

  @override
  State<Poll1> createState() => _PollState();
}

class _PollState extends State<Poll1> {
  TextEditingController poll1 = TextEditingController();
  TextEditingController poll2 = TextEditingController();
  
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
          FloatingActionButton(
            onPressed: addPoll,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildPollRow(int index) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textList[index],
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

  void addPoll() {
    if (counter < 6) {
      setState(() {
        pollIndices.add(nextPollIndex);
        textList.add(TextEditingController()); // Add new controller
        nextPollIndex++;
        counter++;
      });
    }
  }

  void removePoll(int index) {
    setState(() {
      textList[index].dispose(); // Dispose of the controller
      textList.removeAt(index); // Remove controller from the list
      pollIndices.removeAt(index); // Remove poll from indices
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
