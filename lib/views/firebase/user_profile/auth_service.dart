
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final _auth = FirebaseAuth.instance;
  /// Sign up

  Future<String?> AccountCreate(String email,String password)async{
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('User id --------> ${user.user?.uid}');
      return 'success';
    }on FirebaseException catch(e){
      return e.message;
    }
    catch(e){
      return 'something went wrong';
    }
  }
}