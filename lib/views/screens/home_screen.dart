
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing_project/views/screens/display_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),

            SizedBox(height: 20,),

            GestureDetector(
              onTap: ()async{
                setState(() {
                  isLoading = true;
                });
                try{
                  final currentUserId = FirebaseAuth.instance.currentUser;
                  if (currentUserId == null) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('User not logged in!'),
                    ));
                    return;
                  }


                  final uid = currentUserId.uid;
                  await FirebaseFirestore.instance.collection('users').doc(uid).collection('userdata').add(
                      {
                        'first_name' : firstNameController.text,
                        'last_name' :  lastNameController.text
                      }
                  );

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Success added')));


                  setState(() {
                    isLoading = false;
                  });


                  print('Navigating to DisplayData screen');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayScreen(first: firstNameController.text,
                  last: lastNameController.text,)));
                }catch(e){
                  print('error --------> ${e.toString()}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Success issue')));
                  setState(() {
                    isLoading = false;
                  });
                }finally{
                  setState(() {
                    isLoading = false;
                  });
                }


              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: isLoading ? Text('Loading...') : Text('Add') ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
