import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/Custom_Widgets/poll_build.dart';

class CreatepostV1 extends StatefulWidget {
  const CreatepostV1({super.key});

  @override
  State<CreatepostV1> createState() => _CreatepostV1State();
}

class _CreatepostV1State extends State<CreatepostV1> {
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
         poll.add(BuildPoll(poll1: poll1, poll2: poll2, removePoll: removePoll,));
         built=true;
      }
      
    }); 
  }


  void removePoll(){
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