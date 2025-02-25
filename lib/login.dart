import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reddit_attempt2/signup.dart';
import 'firebase_auth_implementation/firebase_auth.dart';
import 'Home.dart';
class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: const Icon(Icons.exit_to_app), onPressed: Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup())),)
        
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column (
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Log in', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,  )),
              SizedBox(height: 20),
              const Text('By continuing you agree to our User Agreement and Privacy policy', textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0,),),
              SizedBox(height: 20),
          
              ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.blue,
          
                ),
                
                onPressed:signinwithgoogle,
                
                child : const Text("Continue with Google", style: TextStyle(color: Colors.blue)),
          
              ),
          
              ElevatedButton(                
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.blue,
                  
                ),
                
                onPressed:() {},
                
                child : const Text("Continue with Apple", style: TextStyle(color: Colors.blue)),
          
              ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black,
              thickness: 0.7,
              indent: 10.0,
              endIndent: 10.0,
            ),
            
            SizedBox(
              height: 20,
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
          
              SizedBox(height: 20),
          
              GestureDetector(
                onTap: () {},
                child: const Text('Forgot Password ?', style: TextStyle(color:Colors.blue),
                )),
          
              SizedBox(height: 200),
          
              SizedBox(
                width: MediaQuery.of(context).size.width*1,
                height: MediaQuery.of(context).size.height*0.07,
                child: ElevatedButton(
                  onPressed: Login, 
                  child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 226, 73, 2),
                    //fixedSize: MediaQuery.of(context).size * 1
                  ),
                  ),
              ),
            
            ],
            ),
        ),
      )
      
    );  
  }

  void Login() async{
    String email = emailController.text.trim();
    String password= passwordController.text.trim();
    User? user = await FirebaseAuthImplementation().Login(email, password);
    if(user != null){
      print("Successfully logged in");
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
      //Navigator.pushNamed(context, "/home");
      }
    else {
      print("Unable to log in");
    }
  }

  void signinwithgoogle() async{
    User? user= await FirebaseAuthImplementation().LoginWithGoogle();
    if(user != null){
      print("Successfully logged in with google");
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
      //Navigator.pushNamed(context, "/home");
      }
    else {
      print("Unable to log in with google");
    }
  }

}