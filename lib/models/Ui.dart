import 'package:flutter/material.dart';

class Ui{
  final String hardware_name;
  final Widget route;
  final IconData icon;
  String brand_name;




  Ui({
    required this.hardware_name,
    required this.route,
    required this.icon,
    required this.brand_name,
  });

  void setName(String s){
    brand_name = s;
    print(s);
  }

  String getName(){
    return brand_name;
  }

}
