import '../models/Ui.dart';
import '../pages/cpupage.dart';
import '../pages/gpupage.dart';
import '../pages/rampage.dart';
import '../pages/motherboardpage.dart';
import '../pages/powersupplypage.dart';
import '../pages/storagepage.dart';
import '../pages/casepage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/specs.dart';

enum hardware {CPU, GPU, Motherboard, RAM, Storage, Case, PowerSupply}

class PCBuilder extends StatefulWidget {
  @override
  _PCBuilderState createState() => _PCBuilderState();
}

class _PCBuilderState extends State<PCBuilder> {


  Specs specs = new Specs(
    CPU: 'none', GPU: 'none', MotherBoard: 'none', RAM: 'none', Storage: 'none', Case: 'none', PowerSupply: 'none',
  );

  bool anyChanges = false;

  List<Ui> hardwarepart_list = [
    Ui(
      hardware_name : 'CPU',
      route : CPUPage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'GPU',
      route : GPUPage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'Motherboard',
      route : MotherBoardPage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'RAM',
      route : RAMPage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'Storage',
      route : StoragePage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'Case',
      route : CasePage(),
      icon : Icons.person,
      brand_name: 'None',
    ),

    Ui(
      hardware_name : 'PowerSupply',
      route : PowerSupplyPage(),
      icon : Icons.person,
      brand_name: 'None',
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
            specs.CPU = '$result';
            break;
          case 1:
            specs.GPU = '$result';
            break;
          case 2:
            specs.MotherBoard = '$result';
            break;
          case 3:
            specs.RAM = '$result';
            break;
          case 4:
            specs.Storage = '$result';
            break;
          case 5:
            specs.Case = '$result';
            break;
          case 6:
            specs.PowerSupply = '$result';
            break;
        }
      });


  }

  int myReference = 0;

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
    return WillPopScope(
      onWillPop: () async{
        if(!anyChanges)
          return true;

        final shouldsave = await showMyDialog();

        Navigator.pop(context, json.encode(specs.toJson()));
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
                  myReference = index;
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
