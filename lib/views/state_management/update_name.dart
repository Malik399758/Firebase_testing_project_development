


import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/state_management/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  final updateController = TextEditingController();

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
        title: Text('Update Name'),
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
                    controller: updateController,
                    decoration: InputDecoration(
                        hintText: 'Enter you name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    value.getUser(updateController.text.trim());
                    updateController.clear();
                    print('Update name Add : ${value.userName}');
                  },
                      child: Center(child: Text('Update Add name'))),
        /*          ElevatedButton(onPressed: (){
                    value.clearName();
                    print('Empty : ${value.userName}');
                  },
                      child: Center(child: Text('Clear name'))),*/
                  Divider(),
                  Text(value.userName.toString())
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
