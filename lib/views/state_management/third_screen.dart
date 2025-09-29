
import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/state_management/update_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                UpdateName()));
          }, icon: Icon(Icons.arrow_forward))
        ],
        title: Text('Third screen'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<UserProvider>(builder: (context,value,_){
        return Center(child: Text(value.userName));
      }),
    );
  }
}
