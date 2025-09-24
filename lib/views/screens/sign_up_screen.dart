
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing_project/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
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
                  UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  print('Cred -------> ${cred.user!.uid}');
                  print('Email -------> ${cred.user!.email}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Success'),
                  ));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  setState(() {
                    isLoading = false;
                  });
                } on FirebaseException catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Firebase error ${e.toString()}'),
                  ));
                  setState(() {
                    isLoading = false;
                  });
                }
                catch(e){
                  print('error -----> ${e.toString()}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Issue ${e.toString()}'),
                  ));
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
                child: Center(child: isLoading ? Text('Loading...') : Text('Sign up') ),
              ),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              HomeScreen()));
            }, icon: Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
