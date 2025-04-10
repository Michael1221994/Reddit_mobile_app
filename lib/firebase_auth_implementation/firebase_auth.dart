import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthImplementation {

  FirebaseAuth _auth=FirebaseAuth.instance;


  User? getCurrentUser () {
    return _auth.currentUser;
  }
  Future<User?> Signup(String email, String password)async{
    try {
      UserCredential Credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return Credential.user;
    }
    catch (e) {
      print(e);
    }
    return null;
  } 

  Future <User?> Login(String email, String password)async{
    try {
      UserCredential Credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Credential.user;
    }
    catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> SignupWithGoogle()async{
    try{
      UserCredential credential =await _auth.signInWithPopup(GoogleAuthProvider());
      return credential.user;
    }
    catch(e){
      print(e);
    }
    return null;
  }

  Future<User?> LoginWithGoogle()async{
    try{
      final googleuser=await GoogleSignIn.standard().signIn();
      final googleauth=await googleuser?.authentication;
      final credential=GoogleAuthProvider.credential(accessToken: googleauth?.accessToken, idToken: googleauth?.idToken);
      UserCredential userCredential=await _auth.signInWithCredential(credential);
      return userCredential.user;
    }
    catch(e){
      print(e);
    }
    return null;
  }
}