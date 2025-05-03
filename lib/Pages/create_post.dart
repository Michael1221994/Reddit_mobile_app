import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/Custom_Widgets/poll_build.dart';
import 'package:reddit_attempt2/Pages/postTo_Page.dart';
import 'package:reddit_attempt2/Services/firestore.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:reddit_attempt2/models/postmodel.dart';

class CreatepostV1 extends StatefulWidget {
  const CreatepostV1({super.key});

  @override
  State<CreatepostV1> createState() => _CreatepostV1State();
}

class _CreatepostV1State extends State<CreatepostV1> {
  final FirebaseAuth auth= FirebaseAuth.instance;
  final FirestoreService firestoreService= FirestoreService();
  final postData post= postData();

  TextEditingController Title=TextEditingController();
  TextEditingController bodyTextController=TextEditingController();
  TextEditingController poll1 = TextEditingController();
  TextEditingController poll2 = TextEditingController();
  bool containsPost=false;
  int pollDurationDays=2;

  

  Map<int, TextEditingController> textControllers = {
    0: TextEditingController(), // Controller for the first input field
    1: TextEditingController(), // Controller for the second input field
    2: TextEditingController(), // Controller for the third input field
    3: TextEditingController(), // Controller for the fourth input field
  };

    @override
  void initState() {
    super.initState();

    // Add listeners to your controllers
    bodyTextController.addListener(_updateButtonState);
    poll1.addListener(_updateButtonState);
    poll2.addListener(_updateButtonState);
    LinkController.addListener(_updateButtonState);
  }
  bool isPostValid = false;

void _updateButtonState() {
  final newState = containPost();
  if (newState != isPostValid) {
    setState(() {
      isPostValid = newState;
    });
  }

  if(poll1.text.isNotEmpty && poll2.text.isNotEmpty){
    setState(() {
      post_type="poll";
    });
    }
  if(_image!=null){
    setState(() {
      post_type="image";
      });
  }
  if(LinkController.text.isNotEmpty){
    setState(() {
      post_type="link";
      });
  }
  if(poll1.text.isEmpty && poll2.text.isEmpty && _image==null && LinkController.text.isEmpty&&(Title.text.isNotEmpty || bodyTextController.text.isNotEmpty )){
    setState(() {
      post_type="text";
  });
    
  }
}


void create_post(){
  var user = auth.currentUser;

}

Future<Uri> uploadImage() async {
  final url = Uri.parse('cloudinary://134133616429799:DqmIoYH4rU74EqJ44bF59m8eqCQ@dsqlubyvz');
  final request = http.MultipartRequest('POST', url);
  request.fields['upload_preset'] = 'Reddit_attempt';
  request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
  
  final response = await request.send();
  final responseData = await response.stream.bytesToString();
  
  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString =String.fromCharCodes(responseData);
    final jsonMap = jsonDecode(responseString);
    setState(() {
      final url = jsonMap['url'];
      final _imageUrl = url;
    });
    return url;
  } else {
    throw Exception('Upload failed with status ${response.statusCode}. Response: $responseData');
  } }

  List<int> pollIndices = []; // Track added polls
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  TextEditingController LinkController =  TextEditingController();
  bool showfield=false;
  TextField? linktextfield;
  List<Widget> _textFields = [];
  List<Widget> poll= [];
  late String post_type;
  int counter = 2; // Already have 2 polls
  int nextPollIndex = 0;
  bool built=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        actions: [
            Row(
            children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: isPostValid ? choose_community : null,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                     color: isPostValid ? Colors.blue[900] : Colors.grey, borderRadius: BorderRadius.circular(20)),
                  child: const Text("Next", style: TextStyle(color: Colors.white),),),
              ),
            )
          ],
        ),
        ],

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
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Wrap(
                    children:_textFields,
                  ),
                ),
                TextField(
                  controller: bodyTextController, decoration: InputDecoration(labelText: "body text (optional)", floatingLabelBehavior: FloatingLabelBehavior.never, border: InputBorder.none, labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,)),), 
                const SizedBox(height: 10),
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

  bool containPost() {
    if(bodyTextController.text.isNotEmpty || (poll2.text.isNotEmpty && poll1.text.isNotEmpty ) || poll1.text.isNotEmpty || _image != null || LinkController.text.isNotEmpty ){
      
        return true;
     
      }
      return false;
  }



  

  void addtextfield(){
    setState(() {
      if(showfield==false){
        // ignore: prefer_conditional_assignment
        if(linktextfield==null){
          linktextfield=TextField(
          controller: LinkController,
           decoration: const InputDecoration(
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
      _updateButtonState();
  }

  void _addPollBuild(){
    setState(() {
      if(!built&&poll.isEmpty){
         poll.add(BuildPoll(poll1: poll1, poll2: poll2, removePoll: removePoll, onDaySelected: (value) {
          print("Parent received selected value: $value");
          // Save this in a variable or state if you want
        },));
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

  void choose_community() {
    post.title=Title.text;
    post.text=bodyTextController.text;
    post.link=LinkController.text;
    post.image=_image;
    post_type=post_type;
    if(post_type=="poll"){
      post.poll1=poll1.text;
      post.poll2=poll2.text;
      post.pollOptions=textControllers;
      post.pollDurationDays=pollDurationDays;
    }
    if(post_type=="image" || post_type=="video"){
      post.image=_image;
    }
    if(post_type=="link"){
      post.link=LinkController.text;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  postTo(post:post)));
  }


}