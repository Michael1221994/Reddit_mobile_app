import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  Key pollSectionKey = UniqueKey();

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
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Allows column to shrink and grow dynamically
              children: [
                TextField(controller: Title, decoration: InputDecoration(labelText: 'Title', floatingLabelBehavior: FloatingLabelBehavior.never, border: InputBorder.none, labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1,)),),
                SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Wrap(
                    children:_textFields,
                  ),
                ),
                TextField(
                  controller: TextController, decoration: InputDecoration(labelText: "body text (optional)", floatingLabelBehavior: FloatingLabelBehavior.never, border: InputBorder.none, labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,)),), 
                SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Wrap(
                    children:poll,
                    ),
                ),
                SizedBox(
                  height: (poll.isEmpty ) ? 20: 350,
                ),
                Row(
                  children: [
                    IconButton(onPressed: (poll.isEmpty && _image == null) ? addtextfield : null, icon: Icon(Icons.link, color: (poll.isEmpty &&  _image == null) ? Colors.black : Colors.grey,)),
                    IconButton(onPressed: (poll.isEmpty && _textFields.isEmpty && _image == null) ?_pickImage: null, icon: Icon(Icons.photo, color: (poll.isEmpty && _textFields.isEmpty && _image == null) ? Colors.black : Colors.grey,)),
                      //IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_outline_outlined, color: Colors.black,)),
                    IconButton(onPressed: (poll.isEmpty && _textFields.isEmpty && _image == null)?_addPollBuild : null, icon: Icon(Icons.poll_outlined, color: (poll.isEmpty && _textFields.isEmpty && _image == null) ? Colors.black : Colors.grey,)),
                  ]
                )
              ],
              ),
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
void updatePollSection() {
    pollSectionKey = UniqueKey();  // Change the key to force rebuild
  }
  Widget buildpoll() {
  return Container(
    
    decoration: BoxDecoration(border: Border.all(), color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
    //height: MediaQuery.of(context).size.height * 0.5, // Set a finite height
    width: MediaQuery.of(context).size.width*0.8,
    child: SingleChildScrollView(
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
            SizedBox(
              height: 10,
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
            SizedBox(
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

Widget buildPollRow(int index) {
  return Row(
    key: ValueKey(index),
    children: [
      Flexible(
        fit: FlexFit.loose,
        child: TextField(
          controller: textControllers[pollIndices[index]], // Correctly reference the controller based on current index
          decoration: const InputDecoration(labelText: "Other poll"),
        ),
      ),
      IconButton(
        icon:  Icon(Icons.cancel),
        onPressed: () => removePolls(index),
      ),
      
    ],
  );
}

//void addPoll() {
  //if (counter < 6) {
    //print("adding poll");
    //setState(() {
      //int newIndex = textControllers.length;
      //textControllers[newIndex] = TextEditingController(); // Dynamically add a new controller to the map
      //pollIndices.add(newIndex); // Use newIndex to track added polls correctly
      //nextPollIndex++;
      //newpoll.add(buildPollRow(newIndex));
      //counter++;
    //});
  //}
//}

void removeasIsaid(){
  print("Just got called");
}
void addPollRow() {
  print("ADD Poll Pressed");
  //if (counter < 6) { // assuming you want a max of 5 polls
    setState(() {
      int newIndex = pollIndices.length; // New index based on the current number of polls
      if (!textControllers.containsKey(newIndex)) { // Check if controller already exists
        textControllers[newIndex] = TextEditingController(); // Add new controller if not exists
      }
      pollIndices.add(newIndex); // Add new index to track
     newpoll = [
      for (int i = 0; i < newpoll.length; i++)
        buildPollRow(i), // Rebuild all existing rows
      buildPollRow(newIndex) // Add new row
    ];
    
    // 2. Force parent rebuild
    poll = [
      Container(
        key: UniqueKey(), // New key forces rebuild
        child: buildpoll(), // Recreate entire poll widget
      )
    ];
    
    counter++;
      updatePollSection();
    });
 // }
}


void removePolls(int index) {

  if (index < 0 || index >= pollIndices.length) {
    // If the index is out of range, return early to prevent errors
    print("Index out of range");
    
  }

  setState(() {
    

    
    final keyToRemove = pollIndices[index];
    if (textControllers.containsKey(keyToRemove)) {
      textControllers[keyToRemove]!.dispose(); // Dispose the controller
      textControllers.remove(keyToRemove); // Remove controller from the map
    }
    newpoll = [
          for (int i = 0; i < pollIndices.length; i++)
            buildPollRow(i) // Rebuild all remaining rows
        ];

     WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          poll = [buildpoll()]; // Complete rebuild
        });
      }
    });
    
    // Rebuild the newpoll list by removing the widget associated with the removed controller
    newpoll = List<Widget>.from(newpoll.where((element) => element.key != ValueKey(keyToRemove)));

    counter--;
    //updatePollSection();
  });

}


 //void removePolls(int index) {
  //print("REMOVE POLL PRESSED");
  //setState(() {
    
    //int keyToRemove = pollIndices[index];
    //textControllers[keyToRemove]?.dispose(); // Dispose of the controller
    //textControllers.remove(keyToRemove); // Remove controller from the map
    //pollIndices.removeAt(index); // Adjust indices list accordingly
    //counter--;
    //newpoll.removeLast();
    //newpoll.remove(buildPollRow(index));
  //});
//}

}