

import 'package:firebase_testing_project/controllers/item_provider.dart';
import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/state_management/update_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart screen'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<ItemProvider>(
        builder: (context,value,_){
          return Expanded(
            child: ListView.builder(
                itemCount: value.task.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return ListTile(
                title: Text(value.task[index]),
              );
            }),
          );
        },
      )
    );
  }
}
