
import 'package:firebase_testing_project/views/firebase/user_profile/firebase_service.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/title_and_desc_screen.dart';
import 'package:firebase_testing_project/views/firebase/user_profile/user_profile_model.dart';
import 'package:flutter/material.dart';

class AllFetchData extends StatefulWidget {
  const AllFetchData({super.key});

  @override
  State<AllFetchData> createState() => _AllFetchDataState();
}

class _AllFetchDataState extends State<AllFetchData> {

  ProfileModel? profile;

  /// fetch

  // Future<void> fetchAllData()async{
  //   try{
  //     final data = await FirebaseService().fetchData();
  //     if(data != null){
  //       setState(() {
  //         profile = data;
  //       });
  //     }
  //   }catch(e){
  //     print('Fetch error ----> ${e.toString()}');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchAllData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('All fetch data'),
          SizedBox(height: 40,),
          Text('First Name : ${profile?.firstName}'),
          Text('Last Name : ${profile?.lastName}'),
          Text('Email : ${profile?.email}'),
          Text('City : ${profile?.city}'),
          SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              TitleAndDescScreen()));
            },
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child:Text('Save')),
            ),
          )
        ],
      )),
    );
  }
}
