import 'package:flutter/material.dart';
import 'package:reddit_attempt2/createPost.dart';
import 'package:reddit_attempt2/create_post.dart';
import 'package:reddit_attempt2/login.dart';
import 'container.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  
  @override
  Widget build(BuildContext context) {
    String headtitle= "reddits"; 
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
              title: Text("+ Create a community"),
            ),
            ListTile(
              title: GestureDetector(
                  onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Login())
                  );},
                  child: Text('Login', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),)
                ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //container(post_type: post_type, number_of_comments: number_of_comments, number_of_upvotes: number_of_upvotes, number_of_downvotes: number_of_downvotes, flaires: flaires)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 226, 73, 2),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: IconButton(onPressed:(){}, icon: Icon(Icons.home),),label: "Home"),
          BottomNavigationBarItem(icon: IconButton(onPressed:(){}, icon: Icon(Icons.search)), label:"communities"),
          BottomNavigationBarItem(icon: IconButton(onPressed:createpost, icon: Icon(Icons.add)), label: "Create"),
          BottomNavigationBarItem(icon: IconButton(onPressed:(){}, icon: Icon(Icons.message_outlined)), label: "Chat"),
          BottomNavigationBarItem(icon: IconButton(onPressed:(){}, icon: Icon(Icons.notifications)), label: "Inbox")
        ],
      ),
    );

  }
  void createpost (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Createpost()));
  }
}