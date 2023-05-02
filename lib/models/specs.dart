import 'package:flutter/material.dart';

class Specs{
  final String CPU;
  final String GPU;
  final String MotherBoard;
  final String RAM;
  final String Storage;
  final String Case;
  final String PowerSupply;

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



}