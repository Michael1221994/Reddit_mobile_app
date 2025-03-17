import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/poll.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
  
  final ImagePicker _picker = ImagePicker();
  var dialog;
  XFile? _image;
  TextEditingController TitleController = TextEditingController();
  TextEditingController TextController =  TextEditingController();
  TextEditingController LinkController =  TextEditingController();
  TextField? linktextfield;
  bool showfield=false;
  bool showpoll= false;
  List<Widget> poll= [];
    // List to hold dynamic TextFields
  List<Widget> _textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
            TextField(controller: TitleController, decoration:InputDecoration(
              labelText: 'Title', labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, ),
              border: InputBorder.none,
            ) ,),
            Expanded(
              child: Wrap(
                //spacing: 8.0, // gap between adjacent chips
                //runSpacing: 4.0, // gap between lines
                children: _textFields,
              ),
            ),
            
            TextField(
              controller: TextController,
              decoration: InputDecoration(
                labelText: "body text (optional)", 
              ),        
            ),
            Expanded(
              child: Wrap(
                children: poll,
              ),
            ),
            
            Row(
              children: [
                IconButton(onPressed: addtextfield, icon: Icon(Icons.link, color: Colors.black,)),
                IconButton(onPressed: _pickImage, icon: Icon(Icons.photo, color: Colors.black,)),
                //IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_outline_outlined, color: Colors.black,)),
                IconButton(onPressed: _addPollBuild, icon: Icon(Icons.poll_outlined, color: Colors.black,)),
              ],
              
            ),
            
            
          ],
        ),
      ),
      
    );
  }
    Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

 

  void addtextfield(){
    setState(() {
      if(showfield==false){
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

  void addpoll(){
    setState(() {
      showpoll=!showpoll;
      if(showpoll){
        _textFields.add(Poll1());
      }
      else {
        _textFields.remove(Poll1());
      }
    });

  }

//Not gonna be needed
  void _showPollDialog() {
    dialog=showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Poll1(
              onSave: (Widget savedWidget){
                setState(() {
                  _textFields.add(savedWidget);
                });
              }
            ),

            ),
        ), // Optional: for rounded corners
      );
    },
  );
}

Widget buildpoll(){
  return Expanded(
    child: Container(
      decoration: BoxDecoration(border: Border.all(), color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(children: [IconButton(onPressed: _removePoll, icon: Icon(Icons.cancel))],),
          Column(
            children: [
              TextField(
                controller: poll1,
                decoration: const InputDecoration(labelText: "Poll 1"),
              ),
              TextField(
                controller: poll2,
                decoration: const InputDecoration(labelText: "Poll 2"),
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
          )
        ]
      
      ),
    ),
  );
  
}


 void _addPollBuild(){
    setState(() {
      
        poll.add(buildpoll());
      
    }); 
  }

  void _removePoll(){
    setState(() {
      poll.removeLast();
    });
  }

Widget buildPollRow(int index) {
  return Row(
    children: [
      Expanded(
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

void removePoll(int index) {
  setState(() {
    int keyToRemove = pollIndices[index];
    textControllers[keyToRemove]?.dispose(); // Dispose of the controller
    textControllers.remove(keyToRemove); // Remove controller from the map
    pollIndices.removeAt(index); // Adjust indices list accordingly
    counter--;
  });
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

//Not gonna be needed
  void add_the_dialog(){
    if(dialog!=null){
      setState(() {
        _textFields.add(dialog);
      });
    }
  } 
}