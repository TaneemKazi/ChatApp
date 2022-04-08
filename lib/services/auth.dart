import 'package:chatapp/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///CONDITION ? TRRUE:FALSE
  Users? _usersFromFirebaseUsers(Users users){
    return users != null ? Users(usersId: users.usersId) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try
    {
      //AuthResult is changed to UserCredential
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //FirebaseUser is changed to User
      User? user = result.user;
      return _usersFromFirebaseUsers;
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try
    {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _usersFromFirebaseUsers;
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}