import 'package:flutter/material.dart';

class Specs{
  String CPU;
  String GPU;
  String MotherBoard;
  String RAM;
  String Storage;
  String Case;
  String PowerSupply;

  Specs({
    required this.CPU,
    required this.GPU,
    required this.MotherBoard,
    required this.RAM,
    required this.Storage,
    required this.Case,
    required this.PowerSupply});

  factory Specs.fromJson(Map<String, dynamic> json) {

    return Specs(
      CPU : json['cpu'],
      GPU : json['gpu'],
      MotherBoard : json['motherboard'],
      RAM : json['ram'],
      Storage : json['storage'],
      Case : json['case'],
      PowerSupply : json['powersupply']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'cpu' : CPU,
      'gpu' : GPU,
      'motherboard' : MotherBoard,
      'ram' : RAM,
      'storage' : Storage,
      'case' : Case,
      'powersupply' : PowerSupply,
    };
  }



}