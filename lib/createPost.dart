import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/container.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  TextEditingController Title=TextEditingController();
  TextEditingController TextController=TextEditingController();
  TextEditingController poll1 = TextEditingController();
  TextEditingController poll2 = TextEditingController();

  Map<int, TextEditingController> textControllers = {
    0: TextEditingController(), // Controller for the first input field
    1: TextEditingController(), // Controller for the second input field
    2: TextEditingController(), // Controller for the third input field
    3: TextEditingController(), // Controller for the fourth input field
  };
  List<int> pollIndices = []; // Track added polls
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  TextEditingController LinkController =  TextEditingController();
  bool showfield=false;
  TextField? linktextfield;
  List<Widget> _textFields = [];
  List<Widget> poll= [];
  List<Widget> newpoll= [];

  int counter = 2; // Already have 2 polls
  int nextPollIndex = 0;
  bool built=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              TextField(controller: Title, decoration: InputDecoration(labelText: 'Title', floatingLabelBehavior: FloatingLabelBehavior.never, border: InputBorder.none, labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1,)),),
              Flexible(
                fit: FlexFit.loose,
                child: Wrap(
                  children:_textFields,
                ),
              ),
              TextField(
                controller: TextController, decoration: InputDecoration(labelText: "body text (optional)", floatingLabelBehavior: FloatingLabelBehavior.never, border: InputBorder.none, labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,)),), 
              Flexible(
                fit: FlexFit.loose,
                child: Wrap(
                  children:poll,
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(onPressed: addtextfield, icon: Icon(Icons.link, color: Colors.black,)),
                  IconButton(onPressed: _pickImage, icon: Icon(Icons.photo, color: Colors.black,)),
                    //IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_outline_outlined, color: Colors.black,)),
                  IconButton(onPressed: _addPollBuild, icon: Icon(Icons.poll_outlined, color: Colors.black,)),
                ]
              )
            ],
            ),
      ),
      );
  }

  void addtextfield(){
    setState(() {
      if(showfield==false){
        // ignore: prefer_conditional_assignment
        if(linktextfield==null){
          linktextfield=TextField(
          controller: LinkController,
           decoration: InputDecoration(
              labelText: "link", 
        )     
      );
        }
        
      _textFields.add(linktextfield!);  
      showfield= true;
      }
      else{
        _textFields.remove(linktextfield!);
        showfield=false;
        linktextfield=null;
      }
      
    });
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  void _addPollBuild(){
    setState(() {
      if(!built&&poll.isEmpty){
         poll.add(buildpoll());
         built=true;
      }
      
    }); 
  }


  void _removePoll(){
    setState(() {
      if(built){
        poll.removeLast();
        built=false;
        
      }
    });
  } 

  Widget buildpoll() {
  return Container(
    decoration: BoxDecoration(border: Border.all(), color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
    height: MediaQuery.of(context).size.height * 0.6, // Set a finite height
    child: Padding(
      padding: EdgeInsets.all( 8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          IconButton(onPressed: _removePoll, icon: Icon(Icons.cancel_outlined)),
          TextField(
            controller: poll1,
            decoration: const InputDecoration(labelText: "Poll 1"),
          ),
          TextField(
            controller: poll2,
            decoration: const InputDecoration(labelText: "Poll 2"),
          ),
          //...pollIndices.map((index) => buildPollRow(index)).toList(),
          //ListView.builder(
            //shrinkWrap: true, // Shrink-wrap the ListView
            //physics: NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
            //itemCount: pollIndices.length,
            //itemBuilder: (context, index) {
            //  return buildPollRow(index);
          //},
        //),

        Column(
                children: [Wrap(
                  children:newpoll,
                  ),]
              ),
              
          GestureDetector(
            onTap: addPoll,
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
  );
}

Widget buildPollRow(int index) {
  return Row(
    children: [
      Flexible(
        fit: FlexFit.loose,
        child: TextField(
          controller: textControllers[pollIndices[index]], // Correctly reference the controller based on current index
          decoration: const InputDecoration(labelText: "Other poll"),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () => removePoll(index),
      ),
    ],
  );
}

void addPoll() {
  if (counter < 6) {
    setState(() {
      int newIndex = textControllers.length;
      textControllers[newIndex] = TextEditingController(); // Dynamically add a new controller to the map
      pollIndices.add(newIndex); // Use newIndex to track added polls correctly
      nextPollIndex++;
      newpoll.add(buildPollRow(newIndex));
      counter++;
    });
  }
}

void removePoll(int index) {
  setState(() {
    int keyToRemove = pollIndices[index];
    textControllers[keyToRemove]?.dispose(); // Dispose of the controller
    textControllers.remove(keyToRemove); // Remove controller from the map
    pollIndices.removeAt(index); // Adjust indices list accordingly
    counter--;
    newpoll.removeLast();
  });
}
}