
import 'package:firebase_testing_project/views/firebase/user_profile/auth_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/main_ui_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({super.key});

  @override
  State<SignUpScreen1> createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  /// sign up

  Future<void> _signUp()async{
    setState(() {
      isLoading = true;
    });
    String? result = await AuthService().AccountCreate(emailController.text.trim(), passwordController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? 'unknown error')));
    if(result == 'success'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainUiScreen()));
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                controller: passwordController,
                decoration: InputDecoration(
                    hint: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  await _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: isLoading ? Center(child: CircularProgressIndicator()) :
                  Text('Sign up')),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
