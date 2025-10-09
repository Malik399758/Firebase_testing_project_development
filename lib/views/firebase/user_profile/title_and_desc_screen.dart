
import 'package:firebase_testing_project/views/firebase/user_profile/content_get.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/model/content_model.dart';
import 'package:flutter/material.dart';

class TitleAndDescScreen extends StatefulWidget {
  const TitleAndDescScreen({super.key});

  @override
  State<TitleAndDescScreen> createState() => _TitleAndDescScreenState();
}

class _TitleAndDescScreenState extends State<TitleAndDescScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isLoading = false;

  /// content save

  Future<void> _contentSave()async{
    setState(() {
      isLoading = true;
    });
    try{
      final data = ContentModel(
        title: titleController.text.trim(),
        description: descController.text.trim()
      );

      String? result = await FirebaseService().contentSave(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? 'unknown error')));

      if(result == 'success'){
       /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
        ContentGet()));*/
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print('content error -------> ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hint: Text('Title'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                    hint: Text('Description'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  await _contentSave();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) :
                  Text('Save')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
