import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GPUPage extends StatelessWidget{
  final String data;
  GPUPage({Key? key, required this.data}) : super(key : key);


  List _items = [];


  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/video-card.json');
    final data = json.decode(response) as List;
    _items = [...data]; /// Clones data to our items list
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPU'),
      ),
      body: ElevatedButton(
        onPressed: (){
          readJson();
          print(_items.length);
          //Map<String, dynamic> myMap = _items[0]; /// testing
          Navigator.pop(context, "Test");
        },
        child: Center(
          child: Text('Load GPU contents'),
        )
      ),
    );
  }

}

