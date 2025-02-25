import 'package:flutter/material.dart';

class Poll extends StatefulWidget {
  const Poll({super.key});

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  TextEditingController poll1=TextEditingController();
  TextEditingController poll2=TextEditingController();
  //TextEditingController poll3=TextEditingController();
  //TextEditingController poll4=TextEditingController();
  //TextEditingController poll5=TextEditingController();
  //TextEditingController poll6=TextEditingController();
  List<Widget> polls=<Widget>[];
  Map<String, TextEditingController> controllers = {};
  //Row? pollrow;
  int counter=2;
  late final String pollcontrol;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll ends"),
        
      ),
      body: Center(
        child: Column(
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
                children: polls,

              ),
            ),
            FloatingActionButton(onPressed: addpoll, child: Text("Add poll"),)
          ],
        ),
      ),

    );
  }

  void addpoll() {
    if(counter<6){
      String pollId = 'poll$counter';
      TextEditingController controller = getcontroller(pollId);
      
        Row pollrow= Row(
          children: [
             TextField(
              controller: getcontroller(pollId),
              decoration: InputDecoration(
                labelText: "poll$counter",
                
                
              ),
            ), 
           
            //IconButton(onPressed: removepoll(pollrow), icon: Icon(Icons.cancel_outlined)),
          ],
          
        );
      setState(() {
        polls.add(pollrow);
        counter++;  
      }); 
    }    
  }

  

  TextEditingController getcontroller(String id){
    if(!controllers.containsKey(id)){
      controllers[id]= TextEditingController();
    }
    return controllers[id]!;
  }

  void removepoll (pollrow){
    setState(() {
      polls.remove(pollrow);
      pollrow=null;
      counter--;
    });
  }
}