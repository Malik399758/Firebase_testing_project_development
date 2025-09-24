
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  String first;
  String last;
  DisplayScreen({super.key,required this.first,required this.last});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final currentId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> showDialogBox(BuildContext context,String docId,String first,String last) {
    final TextEditingController updateFirst  = TextEditingController(text: first);
    final TextEditingController updateLast  = TextEditingController(text: last);


    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: updateFirst,
                decoration: InputDecoration(
                  hintText: 'Enter first name',
                ),
              ),
              TextField(
                controller: updateLast,
                decoration: InputDecoration(
                  hintText: 'Enter last name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // dialog close karein
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                
                FirebaseFirestore.instance.collection('users').doc(currentId).collection('userdata').doc(docId).update({
                  'first_name' : updateFirst.text.trim(),
                  'last_name' : updateLast.text.trim()
                });
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated successfully')));
                 Navigator.pop(context);
               //  Navigator.of(context).pop(updatedText); // dialog close with data return
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentId == null) {
      // User is not logged in
      return Scaffold(
        appBar: AppBar(title: Text('Display Data')),
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentId)
            .collection('userdata')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Data error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Data not found'));
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final doc = data[index];
              final docData = data[index].data() as Map<String, dynamic>;
              final docId = doc.id;
              return ListTile(
                leading: CircleAvatar(),
                title: Text(docData['first_name'] ?? ''),
                subtitle: Text(docData['last_name'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () => showDialogBox(context,docId,
                    docData['first_name'] ?? '',
                    docData['last_name'] ?? ''), icon: Icon(Icons.edit)),
                    IconButton(onPressed: () async{
                      await FirebaseFirestore.instance.collection('users').doc(currentId).collection('userdata').doc(docId).delete();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted successfully')));
                    }, icon: Icon(Icons.delete)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

