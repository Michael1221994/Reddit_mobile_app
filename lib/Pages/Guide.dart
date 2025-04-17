import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Pages/Chat_List_Page.dart';
import 'package:reddit_attempt2/Pages/Home.dart';
import 'package:reddit_attempt2/Pages/Inbox.dart';
import 'package:reddit_attempt2/Pages/communities.dart';
import 'package:reddit_attempt2/Pages/createPost.dart';
import 'package:reddit_attempt2/Pages/create_community.dart';
import 'package:reddit_attempt2/Pages/create_post.dart';
import 'package:reddit_attempt2/Pages/login.dart';
import 'package:reddit_attempt2/Pages/search_reddit_page.dart';
class Guide extends StatefulWidget {
  const Guide ({super.key});

  @override
  State<Guide> createState() => _homeState();
}
final FirebaseAuth auth = FirebaseAuth.instance;

final String currentUserID = auth.currentUser!.uid;

class _homeState extends State<Guide> {
  var currentIndex=0;
  String headtitle= "reddits"; 
  @override
  Widget build(BuildContext context) {
    
    final List<Widget> _pages=[
      const Home(),
      const Communities(),
      const SizedBox(),
       Chat(recieverID: '',),
      const Inbox(),

    ];
    return Scaffold(
      appBar: AppBar(
        title:  Text(headtitle, style: TextStyle(color: Color.fromARGB(255, 226, 73, 2)),),
        actions: [
          IconButton(onPressed: push_Search_Reddit, icon: Icon (Icons.search)),
          IconButton(onPressed: (){}, icon: Icon (Icons.person)),

        ],
        /*leading: DrawerButton(
            onPressed: (){},
        ),*/
        ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            const DrawerHeader(child: Text("Your Communities")),
            ListTile(
              title: GestureDetector(child: const Text("+ Create a community"), onTap:() {Navigator.push(context , MaterialPageRoute(builder: (context)=> CreateCommunity(currentUserID: currentUserID,)));}),
            ),
            /*ListTile(
              title: GestureDetector(
                  onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Login())
                  );},
                  child: const Text('Login', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),)
                ),
            ),*/
          ],
        ),
      ),
      body:_pages[currentIndex],
      /*const SingleChildScrollView(
        child: Column(
          children: [
            //container(post_type: post_type, number_of_comments: number_of_comments, number_of_upvotes: number_of_upvotes, number_of_downvotes: number_of_downvotes, flaires: flaires)
          ],
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: Ontab,
        selectedItemColor: const Color.fromARGB(255, 226, 73, 2),
        unselectedItemColor: Colors.black,
        items:  [
          const BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          const BottomNavigationBarItem( icon: Icon(Icons.search), label:"communities"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => createpost (), icon: const Icon(Icons.add)), label: "Create"),
          const BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "Chat"),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Inbox")
        ],
      ),
    );

  }

  void push_Search_Reddit(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const searchReddit()));

  }
  void createpost (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatepostV1()));
  }

  void communitiespush(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Communities(),));
  }

   void homepush(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),));
  }

  void Ontab (int index) {
          setState(() {
            currentIndex = index;
            switch (index) {
              case 0:
                headtitle = "reddits";
                break;
              case 1:
                headtitle = "Communities";
                break;
              case 2:
                headtitle = "Create";
                break;
              case 3:
                headtitle = "Chat";
                break;
              case 4:
                headtitle = "Inbox";
                break;
            }
             // Updates the active tab
          });
        }


        /*
         items:  [
          BottomNavigationBarItem(icon: IconButton(onPressed:() => {setState(() {currentIndex=0; headtitle="reddits";})}, icon: Icon(Icons.home),),label: "Home"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => {setState(() {currentIndex=1; headtitle="Communities";})}, icon: Icon(Icons.search)), label:"communities"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => createpost (), icon: Icon(Icons.add)), label: "Create"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => {setState(() {currentIndex=2; headtitle="Chat";})}, icon: Icon(Icons.message_outlined)), label: "Chat"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => {setState(() {currentIndex=3; headtitle="Inbox";})}, icon: Icon(Icons.notifications)), label: "Inbox")
        ],
         */
  }

