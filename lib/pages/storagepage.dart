import 'package:flutter/material.dart';

class StoragePage extends StatelessWidget{
  final String data;
  StoragePage({Key? key, required this.data}) : super(key : key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage'),
      ),
      body: Center(
        child: Text('Storage'),
      ),
    );
  }

}