import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/model/content_model.dart';
import 'package:flutter/material.dart';

class ContentGet extends StatefulWidget {
  const ContentGet({super.key});

  @override
  State<ContentGet> createState() => _ContentGetState();
}

class _ContentGetState extends State<ContentGet> {
  List<ContentModel>? content;

  @override
  void initState() {
    super.initState();
    _contentGet();
  }

  /// Fetch content data from Firebase
  Future<void> _contentGet() async {
    try {
      final data = await FirebaseService().contentFetch();
      if (data.isNotEmpty) {
        setState(() {
          content = data;
        });
      }
    } catch (e) {
      print('Error -----> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content List'),
      ),
      body: content == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: content!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(content![index].title ?? 'No Title'),
            subtitle: Text(content![index].description ?? 'No Description'),
          );
        },
      ),
    );
  }
}
