import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dev/pages/powersupplypage.dart';
import 'package:mobile_dev/pages/rampage.dart';
import 'package:mobile_dev/pages/storagepage.dart';
import '../models/Ui.dart';
import '../models/specs.dart';
import 'casepage.dart';
import 'cpupage.dart';
import 'gpupage.dart';
import 'motherboardpage.dart';


class PCInfo extends StatefulWidget {
  final Specs userSpec;
  PCInfo({required this.userSpec});

  @override
  _PCInfoState createState() => _PCInfoState(userSpec: userSpec);
}


class _PCInfoState extends State<PCInfo> {
  final Specs userSpec;
  _PCInfoState({required this.userSpec});

  bool anyChanges = false;




  // Future<void> _navigateAndSave(BuildContext context, int index) async{
  //   final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => hardwarepart_list[index].route));
  //
  //   if(result != null)
  //     setState(() {
  //       anyChanges = true;
  //       hardwarepart_list[index].setName('$result');
  //       switch(index){
  //         case 0:
  //           specs.CPU = '$result';
  //           break;
  //         case 1:
  //           specs.GPU = '$result';
  //           break;
  //         case 2:
  //           specs.MotherBoard = '$result';
  //           break;
  //         case 3:
  //           specs.RAM = '$result';
  //           break;
  //         case 4:
  //           specs.Storage = '$result';
  //           break;
  //         case 5:
  //           specs.Case = '$result';
  //           break;
  //         case 6:
  //           specs.PowerSupply = '$result';
  //           break;
  //       }
  //     });
  // }

  Future<bool?>showMyDialog() => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('List has been modified'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context, false);
            },
            child: Text('Discard'),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context, true);
            },
            child: Text('Save'),
          ),

        ],
      )
  );




  @override
  Widget build(BuildContext context) {

    List<Ui> hardwarepart_list = [
      Ui(
        hardware_name : 'CPU',
        route : CPUPage(),
        icon : Icons.person,
        brand_name: userSpec.CPU,
      ),

      Ui(
        hardware_name : 'GPU',
        route : GPUPage(),
        icon : Icons.person,
        brand_name: userSpec.GPU,
      ),

      Ui(
        hardware_name : 'Motherboard',
        route : MotherBoardPage(),
        icon : Icons.person,
        brand_name: userSpec.MotherBoard,
      ),

      Ui(
        hardware_name : 'RAM',
        route : RAMPage(),
        icon : Icons.person,
        brand_name: userSpec.RAM,
      ),

      Ui(
        hardware_name : 'Storage',
        route : StoragePage(),
        icon : Icons.person,
        brand_name: userSpec.Storage,
      ),

      Ui(
        hardware_name : 'Case',
        route : CasePage(),
        icon : Icons.person,
        brand_name: userSpec.Case,
      ),

      Ui(
        hardware_name : 'PowerSupply',
        route : PowerSupplyPage(),
        icon : Icons.person,
        brand_name: userSpec.PowerSupply,
      ),
    ];

    Future<void> _navigateAndSave(BuildContext context, int index) async{
      final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => hardwarepart_list[index].route));

      if(result != null)
        setState(() {
          anyChanges = true;
          hardwarepart_list[index].setName('$result');
          switch(index){
            case 0:
              userSpec.CPU = '$result';
              break;
            case 1:
              userSpec.GPU = '$result';
              break;
            case 2:
              userSpec.MotherBoard = '$result';
              break;
            case 3:
              userSpec.RAM = '$result';
              break;
            case 4:
              userSpec.Storage = '$result';
              break;
            case 5:
              userSpec.Case = '$result';
              break;
            case 6:
              userSpec.PowerSupply = '$result';
              break;
          }
        });
    }


    return WillPopScope(
      onWillPop: () async{
        if(!anyChanges) {
          Navigator.pop(context, json.encode(userSpec.toJson()));
          return true;
        }

        final willsave = await showMyDialog();
        Navigator.pop(context, json.encode(userSpec.toJson()));
        return new Future(() => false);

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Parts to build\t\t\t\t "),
        ),

        body: ListView.builder(
          itemCount: hardwarepart_list.length,
          itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){
                _navigateAndSave(context, index);

              },

              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(hardwarepart_list[index].icon),
                      SizedBox(width : 14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hardwarepart_list[index].hardware_name,
                            style: TextStyle(fontSize: 20.0),
                          ),


                          AutoSizeText(
                            hardwarepart_list[index].getName(),
                            style: TextStyle(fontSize: 14.0),
                            maxLines: 1,
                            minFontSize: 10,
                          ),


                          SizedBox(height: 8.0),
                        ],
                      )
                    ],
                  )
              ),
            );
          },

        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed:() {

          },
        ),
      ),
    );

  }
}