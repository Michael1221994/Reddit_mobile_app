import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit_attempt2/poll.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  TextEditingController TitleController = TextEditingController();
  TextEditingController TextController =  TextEditingController();
  TextEditingController LinkController =  TextEditingController();
  TextField? linktextfield;
  bool showfield=false;
  bool showpoll= false;
    // List to hold dynamic TextFields
  List<Widget> _textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
            TextField(controller: TitleController, decoration:InputDecoration(
              labelText: 'Title', labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1, ),
              border: InputBorder.none,
            ) ,),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: _textFields,
            ),
            
            TextField(
              controller: TextController,
              decoration: InputDecoration(
                labelText: "body text (optional)", 
              ),        
            ),
            Row(
              children: [
                IconButton(onPressed: addtextfield, icon: Icon(Icons.link, color: Colors.black,)),
                IconButton(onPressed: _pickImage, icon: Icon(Icons.photo, color: Colors.black,)),
                //IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_outline_outlined, color: Colors.black,)),
                IconButton(onPressed: _showPollDialog, icon: Icon(Icons.poll_outlined, color: Colors.black,)),
              ],
            )
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

  void _showPollDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Poll1(),
            ),
        ), // Your Poll1 widget
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Optional: for rounded corners
      );
    },
  );
}

}