
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/model/content_model.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';

class FirebaseService{

  final db = FirebaseFirestore.instance;
  
  /// save data

  Future<String?> saveData(String firstName, String lastName, String email, String city) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        return 'user not logged in';
      }

      final profile = ProfileModel(
        uid: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        city: city,
      );

      await db.collection('Main_Collection').add({
        ...profile.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('User ID -----> $userId');
      return 'success';
    } catch (e) {
      print('Error saving data: $e');
      return 'something went wrong';
    }
  }


  /// fetch data

  Future<List<ProfileModel>> fetchAllProfiles() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        print('User not logged in');
        return [];
      }

      final querySnapshot = await db
          .collection('Main_Collection')
          .where('uid', isEqualTo: userId).orderBy('createdAt').
          get();

      if (querySnapshot.docs.isNotEmpty) {
        final profiles = querySnapshot.docs.map((doc) {
          return ProfileModel.fromMap(doc.data());
        }).toList();

        print('Fetched ${profiles.length} profile(s)');
        return profiles;
      } else {
        print('No profiles found for user');
        return [];
      }
    } catch (e) {
      print('Error fetching profiles: $e');
      return [];
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
/*
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
  }*/





}