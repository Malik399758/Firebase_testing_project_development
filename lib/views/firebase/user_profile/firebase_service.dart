
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';

class FirebaseService{

  final db = FirebaseFirestore.instance;
  
  /// save data

  Future<String?> saveData(ProfileModel profile)async{

    try{
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await db.collection('Users_profile').doc(userId).collection('profile').doc('mainProfile').set(profile.toMap());
      print('user id -----> ${userId}');
      return 'success';
    }catch(e){
      return 'something went wrong';
    }
  }

  /// fetch data

  Future<ProfileModel?> fetchData()async{
    try{
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final snapshot = await db.collection('Users_profile').doc(userId).collection('profile').doc('mainProfile').get();


      if(snapshot.exists){
        final data = snapshot.data();
        print('Data ------> ${data}');
        return ProfileModel.fromMap(data!);
      }else{
        print('user data not found');
        return null;
      }

    }catch(e){
      print('Error fetching data: $e');
      return null;
    }
  }
  
}