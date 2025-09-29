

import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/state_management/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFirstScreen extends StatefulWidget {
  const UserFirstScreen({super.key});

  @override
  State<UserFirstScreen> createState() => _UserFirstScreenState();
}

class _UserFirstScreenState extends State<UserFirstScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            SecondScreen()));
          }, icon: Icon(Icons.arrow_forward))
        ],
        title: Text('User Name'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Consumer<UserProvider>(
            builder: (context,value,_){
              return Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Enter you name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    value.getUser(nameController.text.trim());
                    nameController.clear();
                    print('Add : ${value.userName}');
                  },
                      child: Center(child: Text('Add name'))),
                  ElevatedButton(onPressed: (){
                    value.clearName();
                    print('Empty : ${value.userName}');
                  },
                      child: Center(child: Text('Clear name'))),
                  Divider(),
                  Text(
                    value.userName.isNotEmpty ? 'Name : ${value.userName.toString()}' :
                        'Empty Name: ${value.userName.toString()}',style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w600
                  ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
