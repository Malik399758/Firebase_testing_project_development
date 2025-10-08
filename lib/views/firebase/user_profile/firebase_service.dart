
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/model/content_model.dart';
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


  /// ------------- content -----------------

  /// save content
  Future<String?> contentSave(ContentModel content)async{
    try{
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await db.collection('Users_profile').doc(userId).collection('content').add(content.toMap());
      return 'success';
    } on FirebaseException catch(e){
      return e.message;
    }
    catch(e){
      print('Content error -------> ${e.toString()}');
      return 'something went wrong';
    }
  }

  /// get content

  Future<List<ContentModel>> contentFetch() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print('Fetching content for user: $userId');

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users_profile')
          .doc(userId)
          .collection('content')
          .get();

      print('Documents found: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isEmpty) return [];

      List<ContentModel> contents = [];

      for (var doc in querySnapshot.docs) {
        print('Doc data: ${doc.data()}');
        contents.add(ContentModel.fromMap(doc.data()));
      }

      return contents;
    } catch (e) {
      print('Fetch error: $e');
      return [];
    }
  }





}