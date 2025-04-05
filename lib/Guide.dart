import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Chat.dart';
import 'package:reddit_attempt2/Home.dart';
import 'package:reddit_attempt2/Inbox.dart';
import 'package:reddit_attempt2/communities.dart';
import 'package:reddit_attempt2/createPost.dart';
import 'package:reddit_attempt2/create_community.dart';
import 'package:reddit_attempt2/create_post.dart';
import 'package:reddit_attempt2/login.dart';
import 'container.dart';
class Guide extends StatefulWidget {
  const Guide ({super.key});

  @override
  State<Guide> createState() => _homeState();
}

class _homeState extends State<Guide> {
  var currentIndex=0;
  String headtitle= "reddits"; 
  @override
  Widget build(BuildContext context) {
    
    final List<Widget> _pages=[
      const Home(),
      const Communities(),
      const SizedBox(),
      const Chat(),
      const Inbox(),

    ];
    return Scaffold(
      appBar: AppBar(
        title:  Text(headtitle, style: TextStyle(color: Color.fromARGB(255, 226, 73, 2)),),
        /*leading: DrawerButton(
            onPressed: (){},
        ),*/
        ),
      drawer: Drawer(
        child: ListView(
          children:  [
            DrawerHeader(child: Text("Your Communities")),
            ListTile(
              title: GestureDetector(child: const Text("+ Create a community"), onTap:() {Navigator.push(context , MaterialPageRoute(builder: (context)=> CreateCommunity()));}),
            ),
            ListTile(
              title: GestureDetector(
                  onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Login())
                  );},
                  child: const Text('Login', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),)
                ),
            ),
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
        selectedItemColor: Color.fromARGB(255, 226, 73, 2),
        unselectedItemColor: Colors.black,
        items:  [
          const BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          const BottomNavigationBarItem( icon: Icon(Icons.search), label:"communities"),
          BottomNavigationBarItem(icon: IconButton(onPressed:() => createpost (), icon: Icon(Icons.add)), label: "Create"),
          const BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "Chat"),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Inbox")
        ],
      ),
    );

  }
  void createpost (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Createpost()));
  }

  void communitiespush(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Communities(),));
  }

   void homepush(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
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

