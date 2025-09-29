import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_project/controllers/user_controller.dart';
import 'package:firebase_testing_project/views/screens/sign_up_screen.dart';
import 'package:firebase_testing_project/views/state_management/user_first_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart' show DefaultFirebaseOptions;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: UserFirstScreen()
        //SignUpScreen()
      ),
    );
  }
}

