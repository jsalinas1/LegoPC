import 'package:flutter/material.dart';

class RAMPage extends StatelessWidget{
  final String data;
  RAMPage({Key? key, required this.data}) : super(key : key);


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RAM'),
      ),
      body: Center(
        child: Text('RAM'),
      ),
    );
  }

}