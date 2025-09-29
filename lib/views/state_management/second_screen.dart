
import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/state_management/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       actions: [
         IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>
               ThirdScreen()));
         }, icon: Icon(Icons.arrow_forward))
       ],
       title: Text('Second screen'),
       centerTitle: true,
       backgroundColor: Colors.green,
     ),
      body: Consumer<UserProvider>(builder: (context,value,_){
        return Center(child:   Text(
          value.userName.isNotEmpty ? 'Name : ${value.userName.toString()}' :
          'Empty Name: ${value.userName.toString()}',style: TextStyle(
            fontSize: 18,fontWeight: FontWeight.w600
        ),
        ));
      }),
    );
  }
}
