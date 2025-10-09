import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';
import 'package:flutter/material.dart';

class GetDataFirebase extends StatefulWidget {
  const GetDataFirebase({super.key});

  @override
  State<GetDataFirebase> createState() => _GetDataFirebaseState();
}

class _GetDataFirebaseState extends State<GetDataFirebase> {
  List<ProfileModel> profiles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfiles();
  }

  void loadUserProfiles() async {
    final result = await FirebaseService().fetchAllProfiles();
    setState(() {
      profiles = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Data'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profiles.isEmpty
          ? const Center(child: Text('No profiles found'))
          : ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ListTile(
            leading: CircleAvatar(child: Text(profile.firstName[0])),
            title: Text('${profile.firstName} ${profile.lastName}'),
            subtitle: Text('${profile.email} • ${profile.city}'),
          );
        },
      ),
    );
  }
}
