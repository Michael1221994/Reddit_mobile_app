import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/chat_bubble.dart';
import 'package:reddit_attempt2/Custom_Widgets/my_textfield.dart';
import 'package:reddit_attempt2/Services/Chat/chat_services.dart';
import 'package:reddit_attempt2/firebase_auth_implementation/firebase_auth.dart';

class Chat extends StatelessWidget {
  final String recieverID;
   Chat({
    super.key,
    required this.recieverID
    });

   final TextEditingController _messageController = TextEditingController();


  final FirebaseAuthImplementation auth=FirebaseAuthImplementation();
  final ChatServices chatServices=ChatServices();

  void sendMessage() async{
      // if there is something inside the textfield
      if(_messageController.text.isNotEmpty){
        //send message
        await chatServices.sendMessage(recieverID, _messageController.text);

        //clear text controller
        _messageController.clear();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Expanded(
                    child: buildMessageList(),
                    ),
                  ),
                  ]
              ),

    );
  }

  Widget buildMessageList() {
    String senderID = auth.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: chatServices.getMessages(senderID, recieverID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      return ListView(
        children: snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
      );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == auth.getCurrentUser()!.uid;

    var alignment =isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)

          ],
          ),        
      ),
    );
  }

  Widget _buildUserInput () {
    return Padding(
      padding:  const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
               //textfield should take up most of the space
        Expanded(
          child: MyTextfield(hintText: "Type a message", obscureText: false, controller: _messageController),
        ),
      
        //send button
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
          ),
          margin: EdgeInsets.only(right: 20),
          child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send, color: Colors.white,),),)
        ]
      ),
    );
   }

}