
import 'package:flutter/material.dart';

class TitleAndDescScreen extends StatefulWidget {
  const TitleAndDescScreen({super.key});

  @override
  State<TitleAndDescScreen> createState() => _TitleAndDescScreenState();
}

class _TitleAndDescScreenState extends State<TitleAndDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Title')),
    );
  }
}
