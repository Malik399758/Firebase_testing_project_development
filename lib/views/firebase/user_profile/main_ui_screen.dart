
import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/get_screen.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';
import 'package:flutter/material.dart';

class MainUiScreen extends StatefulWidget {
  const MainUiScreen({super.key});

  @override
  State<MainUiScreen> createState() => _MainUiScreenState();
}

class _MainUiScreenState extends State<MainUiScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  bool isLoading = false;




  /// save

  Future<void> _saveData()async{
    setState(() {
      isLoading = true;
    });
    try{
      final profile = ProfileModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          city: cityController.text.trim());

      String? result = await FirebaseService().saveData(profile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? 'unknown error')));


      if(result == 'success'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAndUpdateScreen()));
      }
      setState(() {
        isLoading = false;
      });

    }catch(e){
      setState(() {
        isLoading = false;
      });
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
            Text('Profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
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
                await _saveData();
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: isLoading ? Center(child: CircularProgressIndicator()) :
                Text('Save')),
              ),
            )
          ],
        ),
      )
    );
  }
}
