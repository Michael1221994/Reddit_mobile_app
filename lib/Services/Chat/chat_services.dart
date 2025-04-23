import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reddit_attempt2/models/message.dart';


class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream (){
    return _firestore.collection("User").snapshots().map((snapshots) {
      return snapshots.docs.map((doc){
        //go through individual user
        final user= doc.data();
        return user;
      }).toList();
    });
  }


  Future<void> sendMessage( String receiverID, String message) async {
    //get current user
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final  Timestamp timeStamp= Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timeStamp, 
    );
    //construct a chat room ID for the two users sorted and joined
    List<String> ids= [currentUserID, receiverID];
    ids.sort();
    String chatRoomID= ids.join("_");
    

    //add the new message to the database 
    await _firestore 
    .collection("chat_rooms")
    .doc(chatRoomID )
    .collection("messages")
    .add(newMessage.toMap()); 
  }

  //get messages

  Stream<QuerySnapshot> getMessages(String userID, otheruserID) {
    //construct a chat room ID for the two users sorted and joined
    List<String> ids= [userID, otheruserID];
    ids.sort();
    String chatRoomID= ids.join("_");

    return _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();
  }
}