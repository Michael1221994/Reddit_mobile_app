import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth_implementation/firebase_auth.dart';
import 'package:reddit_attempt2/Pages/Guide.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Text("By contuning,you are setting up a Reddit account and you agree to our terms and privacy policy"),
          
              SizedBox(
                height: 30,
              ),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.blue,
          
                  ),
                onPressed: (){}, 
                child: Text("Continue with Google")),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.blue,
          
                  ),
                onPressed: (){}, 
                child: Text("Continue with Apple")),
              
              SizedBox(
                height: 40,
              ),
          
               Divider(
                color: Colors.black,
                thickness: 0.7,
                indent: 10.0,
                endIndent: 10.0,
                
              ),
          
              SizedBox(
                height: 40,
              ),
              
              Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 209, 208, 208),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,                  
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email', labelStyle: TextStyle(fontSize: 13.0),
                      border: InputBorder.none,
                  
                    ),
                    
                  ),
                ),
                SizedBox(height: 10),
            
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 209, 208, 208),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,                  
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.05,
          
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password', labelStyle: TextStyle(fontSize: 13.0),
                      border: InputBorder.none,
                      
                    ),            
                  ),
                ),
             
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                Text('Already have an account? '),
                GestureDetector(
                  onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Login())
                  );},
                  child: Text('Login', style: TextStyle(color: const Color.fromARGB(255, 255, 102, 0), decoration: TextDecoration.underline),)
                )
              ],),

               ElevatedButton(
                onPressed: signup, 
                child: Text("Signup"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 226, 73, 2)
                ),
                ),
            ],
          ),
        ),
      )
    );
  }

  void signup()async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    User? user = await FirebaseAuthImplementation().Signup(email, password);
    if(user != null){
      print("Successfully signed up");
      Navigator.push
      (context, 
      MaterialPageRoute(builder: (context) => Guide())); 
    }
    else {
      print("Failed to sign up");
    }
  }

  void signupwithgoogle() async{
    User? user= await FirebaseAuthImplementation().SignupWithGoogle();
    if(user != null){
      print("Successfully logged in with google");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Guide()));
    }
    else {
      print("Unable to log in with google");
    }
  }
}
