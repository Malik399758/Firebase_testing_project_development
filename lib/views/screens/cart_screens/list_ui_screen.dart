


import 'package:firebase_testing_project/controllers/item_provider.dart';
import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/screens/cart_screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUiScreen extends StatefulWidget {
  const ListUiScreen({super.key});

  @override
  State<ListUiScreen> createState() => _ListUiScreenState();
}

class _ListUiScreenState extends State<ListUiScreen> {
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                CartScreen()));
          }, icon: Icon(Icons.arrow_forward))
        ],
        title: Text('Task Name'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Consumer<ItemProvider>(
            builder: (context,value,_){
              return Column(
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: taskController,
                      decoration: InputDecoration(
                          hintText: 'Enter user task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    value.add(taskController.text.trim());

                  },
                      child: Center(child: Text('Add task'))),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: value.task.length,
                        itemBuilder: (context,index){
                      return ListTile(
                        leading: CircleAvatar(child: Text(index.toString()),),
                        title: Text(value.task[index]),
                        trailing: IconButton(onPressed: (){
                          value.remove(index);
                        },
                            icon: Icon(Icons.delete)),
                      );
                    }),
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
