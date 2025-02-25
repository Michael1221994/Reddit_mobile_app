import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reddit_attempt2/container.dart';
import 'package:reddit_attempt2/create_post.dart';
import 'package:reddit_attempt2/firebase_options.dart';
import 'package:reddit_attempt2/login.dart';
import 'package:reddit_attempt2/splash_screen.dart';
import 'signup.dart';
import 'home.dart';
import 'poll.dart';
import 'poll1.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Poll1(),//splashscreen(),//container(post_type: "post_type", title: "title", text: "Text",   number_of_comments: "number_of_comments", number_of_upvotes: "number_of_upvotes", number_of_downvotes: "number_of_downvotes", flaires: ["flaires"],  image_name: 'lib/assets/reddit.png', video_name: "video_name", link: "link")//splashscreen(),
      
    );
  }
}