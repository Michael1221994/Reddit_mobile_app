import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirestoreService {

    // get instances of firestore
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create the different collections on Firestore
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
   final CollectionReference communityCollection =
      FirebaseFirestore.instance.collection('community');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference commentCollection =
      FirebaseFirestore.instance.collection('comments');
  final CollectionReference subredditCollection =
      FirebaseFirestore.instance.collection('subreddits');
  final CollectionReference historyCollection =
      FirebaseFirestore.instance.collection('history');
  final CollectionReference joinedsubreddits =
      FirebaseFirestore.instance.collection('joinedsubreddits');
  final CollectionReference saves =
      FirebaseFirestore.instance.collection('saves');
  final CollectionReference upvotedownvote =
      FirebaseFirestore.instance.collection('upvotedownvote');
  
  //Time Variables
  DateTime oneDayAgo = DateTime.now().subtract(Duration(days: 1));
  DateTime oneweekago= DateTime.now().subtract(Duration(days: 7));
  DateTime onemonthago= DateTime.now().subtract(Duration(days: 30));
  DateTime oneyearago= DateTime.now().subtract(Duration(days: 365));

  //Create the different documents on Firestore 
  Future<Future<DocumentReference<Object?>>> createPost(String? post_type, String? title, String? Text, DateTime posted_when, String? sub_id, String? user_id, List<String>? flaires,Map<String, int>? pollOptions,int? pollDurationDays, String? image_name, String? video_name, String link) async {  // not sure about image name, video name, post_id, link
    return postCollection.add(
      {
      'title': title,
      'text': Text, 
      'post_type': post_type,
      'posted_when': posted_when,
      'sub_id': sub_id,
      'user_id': user_id,
      'number_of_comments': 0,
      'number_of_upvotes': 0,
      'number_of_downvotes': 0,
      'flaires': flaires,
      'pollOptions': pollOptions,
      'pollDurationDays': pollDurationDays,
      'image_name': image_name,
      'video_name': video_name,
      'link': link
      }
    );
  }

  Future<Future<DocumentReference<Object?>>> createSubreddit(String subreddit_genre, String description, String user_id, String subreddit_name, String subreddit_icon_image, String subreddit_alt_name, String subreddit_background_name) async {
    return subredditCollection.add(
      {
      'subreddit_genre': subreddit_genre,
      'description': description,
      'user_id': user_id,
      'subreddit_name': subreddit_name,
      'subreddit_icon_image': subreddit_icon_image,
      'subreddit_alt': subreddit_alt_name,
      'subreddit_background_name': subreddit_background_name
      }
    
  );
}

Future<DocumentReference<Object?>> createCommunity(String community_name, String community_description, String owner_user_id, bool adult, List<String> members  ) async {
  return communityCollection.add(
    {
    'community_name': community_name,
    'community_description': community_description,
    'owner_user_id': owner_user_id,
    'adult': adult,
    'members': members

    }
  );
  
}

Future<List<Community>> fetchcommunity() async {
  final user = _auth.currentUser!;
  final querySnapshot = await communityCollection
      .where('owner_user_id', isEqualTo: user.uid)
      .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Community(
      name: data['community_name'],
      description: data['community_description'],
      adult: data['adult'] ?? false,
    );
  }).toList();
}

Future<Future<DocumentReference<Object?>>> createComment(String post_id, String user_id, String comment, String sub_Id, String reply_to, DateTime commented_when, int Downvote_count, int upvote_count) async {
  //check if user and post exist
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  var postdoc= await postCollection.doc(post_id).get();
  if(!postdoc.exists) throw("Post does not exist");

  
  return commentCollection.add(
    {
    'post_id': post_id,
    'user_id': user_id,
    'comment': comment,
    'sub_id': sub_Id,
    'reply_to': reply_to,
    'commented_when': commented_when,
    'downvote_count': Downvote_count,
    'upvote_count': upvote_count
    }
  );

}

Future<Future<DocumentReference<Object?>>> createhistory(String user_id, String post_id) async {
   //check if user and post exist
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  var postdoc= await postCollection.doc(post_id).get();
  if(!postdoc.exists) throw("Post does not exist");
  return historyCollection.add(
    {
    'user_id': user_id,
    'post_id': post_id
    }
  );
  
}

Future<Future<DocumentReference<Object?>>> createjoinedsubreddits(String user_id, String sub_id) async{
   //check if user and post exist
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  var subdoc= await subredditCollection.doc(sub_id).get();
  if(!subdoc.exists) throw("Post does not exist");
  return joinedsubreddits.add(
    {
      'user_id': user_id,
      'sub_id': sub_id
    }
  );
}

/*Future<Future<DocumentReference<Object?>>>  fetchjoinedsubreddits(String user_id) async{
  var user= await _auth.currentUser!(user_id);
  var joined_subreddits = await joinedsubreddits.doc(user_id).get();

}*/

Future<Future<DocumentReference<Object?>>> createsaves(String user_id, String post_id) async{
   //check if user and post exist
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  var postdoc= await postCollection.doc(post_id).get();
  if(!postdoc.exists) throw("Post does not exist");
  return saves.add(
    {
      'user_id': user_id,
      'post_id': post_id
    }
  );
}


Future<Future<DocumentReference<Object?>>> createupvotedownvote(String user_id, String? post_id, String? comment_id, bool rating) async {


  if (post_id != null) {
    //check if user and post exist
    var userdoc= await userCollection.doc(user_id).get();
    if(!userdoc.exists) throw("User does not exist");
    var postdoc= await postCollection.doc(post_id).get();
    if(!postdoc.exists) throw("Post does not exist");
    return upvotedownvote.add(
    {
      'user_id': user_id,
      'post_id': post_id,
      //'comment_id': comment_id,
      'rating': rating
    }
    );
  }

  else if (comment_id != null) {
    //check if user and comment exist
    var userdoc= await userCollection.doc(user_id).get();
    if(!userdoc.exists) throw("User does not exist");
    var commentdoc= await commentCollection.doc(comment_id).get();
    if(!commentdoc.exists) throw("Post does not exist");
    return upvotedownvote.add(
    {
      'user_id': user_id,
      //'post_id': post_id,
      'comment_id': comment_id,
      'rating': rating
    }
    );
    
  }
  else if( post_id == null && comment_id == null) throw("Post or comment id is null");
  else throw("Post and comment id cannot both be not null");
  
  
} 


//Retrieve the different collections on Firestore
//Posts
Stream<QuerySnapshot> getPost(String post_id) {
  return postCollection.where('post_id', isEqualTo: post_id).snapshots();
}

Stream<QuerySnapshot> gethotposts() {
  
  return postCollection.where('posted_when', isLessThanOrEqualTo: oneDayAgo).orderBy('number_of_upvotes', descending: true).snapshots();
}

Stream<QuerySnapshot> getNewPosts() {
  
  return postCollection.where('posted_when', isLessThanOrEqualTo: oneDayAgo).orderBy('posted_when', descending: true).snapshots();
}

Future<Stream<QuerySnapshot>> getUserPosts(String user_id) async{
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  return postCollection.where('user_id', isEqualTo: user_id).snapshots();
}

Query<Object?> gettopposts(String when) {
  
  switch(when){
    case 'This day':
      return postCollection.where('posted_when', isGreaterThanOrEqualTo: oneDayAgo).orderBy('posted_when', descending: true);
      break;
    case 'This Week':
      return postCollection.where('posted_when', isGreaterThan: oneweekago).orderBy('posted_when', descending: true);
      break;
    case 'This Month':
      return postCollection.where('posted_when', isGreaterThan: onemonthago).orderBy('posted_when', descending: true);
      break;
    case 'This Year':
      return postCollection.where('posted_when', isGreaterThan: oneyearago).orderBy('posted_when', descending: true);
      break;
    default:
      return postCollection.orderBy('posted_when', descending: true);
  }
}

Query<Object?> getcontroversialposts(String when){
  switch(when){
    case 'This day':
      return postCollection.where('posted_when', isGreaterThanOrEqualTo: oneDayAgo).orderBy('number_of_comments', descending: true);
      break;
    case 'This Week':
      return postCollection.where('posted_when', isGreaterThan: oneweekago).orderBy('number_of_comments', descending: true);
      break;
    case 'This Month':
      return postCollection.where('posted_when', isGreaterThan: onemonthago).orderBy('number_of_comments', descending: true);
      break;
    case 'This Year':
      return postCollection.where('posted_when', isGreaterThan: oneyearago).orderBy('number_of_comments', descending: true);
      break;
    default:
      return postCollection.orderBy('number_of_comments', descending: true);
  }
}

Stream<QuerySnapshot> getsubredditposts(String sub_id, String filter, String filter_with_date){
  final subreddit_stream;
  if(filter== "hot"){
    switch(filter_with_date){
    case 'This day':
      subreddit_stream= postCollection.where('posted_when', isGreaterThanOrEqualTo: oneDayAgo).where('sub_id', isEqualTo: sub_id).orderBy('number_of_upvotes', descending: true);
      break;
    case 'This Week':
      subreddit_stream=postCollection.where('posted_when', isGreaterThan: oneweekago)..where('sub_id', isEqualTo: sub_id).orderBy('number_of_upvotes', descending: true);
      break;
    case 'This Month':
      subreddit_stream= postCollection.where('posted_when', isGreaterThan: onemonthago).where('sub_id', isEqualTo: sub_id).orderBy('number_of_upvotes', descending: true);
      break;
    case 'This Year':
      subreddit_stream=postCollection.where('posted_when', isGreaterThan: oneyearago).where('sub_id', isEqualTo: sub_id).orderBy('number_of_upvotes', descending: true);
      break;
    default:
      subreddit_stream= postCollection.where('sub_id', isEqualTo: sub_id).orderBy('number_of_upvotes', descending: true);
    }
  }
  else if(filter=="new"){
    switch(filter_with_date){
      case 'This day':
        subreddit_stream=postCollection.where('posted_when', isGreaterThanOrEqualTo: oneDayAgo).orderBy('posted_when', descending: true);
        break;
      case 'This Week':
        subreddit_stream= postCollection.where('posted_when', isGreaterThan: oneweekago).orderBy('posted_when', descending: true);
        break;
      case 'This Month':
        subreddit_stream= postCollection.where('posted_when', isGreaterThan: onemonthago).orderBy('posted_when', descending: true);
        break;
      case 'This Year':
        subreddit_stream= postCollection.where('posted_when', isGreaterThan: oneyearago).orderBy('posted_when', descending: true);
        break;
      default:
        subreddit_stream=postCollection.orderBy('posted_when', descending: true);
    }
  }

  else if(filter=="top"){
    subreddit_stream= gettopposts(filter_with_date);
  }

  else {
    subreddit_stream= getcontroversialposts(filter_with_date);
  }
  return subreddit_stream;
}

//Feed

Stream<QuerySnapshot> gethomefeed(String user_id) {
  List<String> joinedsubs= getJoinedSubredditIds(user_id) as List<String>;
  return postCollection.where('sub_id', whereIn: joinedsubs).snapshots();
}

Stream<QuerySnapshot> getallfeed(){
  return postCollection.orderBy('Number_of_upvotes', descending: true).snapshots();
}

//History
Stream<QuerySnapshot> gethistory(String user_id) {

  return historyCollection.where('user_id', isEqualTo: user_id).snapshots();
}



Future<void> clearhistory(String user_id) async{
  var querysnapshot= await historyCollection.where('user_id', isEqualTo: user_id).get();
  WriteBatch batch= FirebaseFirestore.instance.batch();
  for(DocumentSnapshot doc in querysnapshot.docs){
    batch.delete(doc.reference);
  }
  return batch.commit();
}


//Subreddit

Future<Stream<List<String>>> getJoinedSubredditIds(String user_id) async{
   var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  // Access the stream from the original function
  Stream<QuerySnapshot> stream = await getJoinedSubreddits(user_id);

  // Map over the stream and extract sub_id from each document
  return stream.map((QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot document) {
      return (document.data() as Map<String, dynamic>)['sub_id'] as String; // Make sure 'sub_id' exists and is correctly typed
    }).toList();
  });
}

Future<Stream<QuerySnapshot<Object?>>> getJoinedSubreddits(String user_id) async {
  var userdoc= await userCollection.doc(user_id).get();
  if(!userdoc.exists) throw("User does not exist");
  return joinedsubreddits.where('user_id', isEqualTo: user_id).snapshots();
}

  Future<void> updatesubreddit(String sub_id, String subreddit_genre, String description, String user_id, String subreddit_name, String subreddit_icon_image, String subreddit_alt_name, String subreddit_background_name) async {
    
    return subredditCollection.doc(sub_id).update(
      {
      'subreddit_genre': subreddit_genre,
      'description': description,
      'user_id': user_id,
      'subreddit_name': subreddit_name,
      'subreddit_icon_image': subreddit_icon_image,
      'subreddit_alt': subreddit_alt_name,
      'subreddit_background_name': subreddit_background_name
      }
    
  );
}

Future<void> deletesubreddit(String sub_id, String user_id) async{
  return await subredditCollection.doc(sub_id).delete();
}



//Saves
Stream<QuerySnapshot> getsaves(String user_id) {
  return saves.where('user_id', isEqualTo: user_id).snapshots();
}

Future<String> unsave(String save_id) async{
    //check if user and post exist
    //var userdoc= await userCollection.doc(user_id).get();
    //if(!userdoc.exists) throw("User does not exist");
    //var postdoc= await postCollection.doc(post_id).get();
    //if(!postdoc.exists) throw("Post does not exist");
    //var saved= await saves.where( 'user_id', isEqualTo: user_id).where('post_id', isEqualTo: post_id).get();
     await saves.doc(save_id).delete();
     var save= await saves.doc(save_id).get();
     if(save!=null) return "save not deleted";
     else return "save deleted";
}

Stream<QuerySnapshot> getSubreddits() {
  return subredditCollection.snapshots();
}


//Comments
Stream<QuerySnapshot> getComments(String post_id) {
  return commentCollection.where('post_id', isEqualTo: post_id).snapshots();  
}
}

class Community {
  final String name;
  final String description;
  final bool adult;

  Community({required this.name, required this.description, required this.adult});
}
