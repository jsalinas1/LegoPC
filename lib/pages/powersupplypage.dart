import 'package:flutter/material.dart';

class PowerSupplyPage extends StatelessWidget{
  final String data;
  PowerSupplyPage({Key? key, required this.data}) : super(key : key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PowerSupply'),
      ),
      body: Center(
        child: Text('PowerSupply'),
      ),
    );
  }

}