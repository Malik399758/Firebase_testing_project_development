
import 'package:firebase_testing_project/views/firebase/user_profile/all_fetch_data.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';
import 'package:flutter/material.dart';

class GetAndUpdateScreen extends StatefulWidget {
  const GetAndUpdateScreen({super.key});

  @override
  State<GetAndUpdateScreen> createState() => _GetAndUpdateScreenState();
}

class _GetAndUpdateScreenState extends State<GetAndUpdateScreen> {
  var firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    _getUserData();
  }




  /// get

  Future<void> _getUserData()async{
    try{
      final profile = await FirebaseService().fetchData();


      if(profile != null){
        firstNameController.text = profile.firstName;
        lastNameController.text = profile.lastName;
        emailController.text = profile.email;
        cityController.text = profile.city;
      }
    }catch(e){
      print('Firebase ------> ${e.toString()}');
    }
  }


  /// update

  Future<void> _updateData()async{
    try{
      final profile = ProfileModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email : emailController.text.trim(),
          city: cityController.text.trim()
      );

      String? result = await FirebaseService().saveData(profile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? 'unknown error')));

      if(result == 'success'){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
        AllFetchData()));
      }
    }catch(e){
      print('Update error------> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Update',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hint: Text('First Name'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    hint: Text('Last Name'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hint: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                    hint: Text('City'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  await _updateData();
                  //await _getUserData();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: isLoading ? Center(child: CircularProgressIndicator()) :
                  Text('Save Update')),
                ),
              )
            ],
          ),
        )
    );
  }
}
