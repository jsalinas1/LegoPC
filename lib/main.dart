import 'package:flutter/material.dart';
import '../models/Ui.dart';
import '../pages/cpupage.dart';
import '../pages/gpupage.dart';
import '../pages/rampage.dart';
import '../pages/motherboardpage.dart';
import '../pages/powersupplypage.dart';
import '../pages/storagepage.dart';
import '../pages/casepage.dart';


void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("PC Builders"),
        ),
        body: PCBuilder(), // Test
      ),
    );
  }
}

class PCBuilder extends StatefulWidget {
  @override
  _PCBuilderState createState() => _PCBuilderState();
}

class _PCBuilderState extends State<PCBuilder> {

  List<Ui> hardwarepart_list = [
    Ui(
      hardware_name : 'CPU',
      route : CPUPage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'GPU',
      route : GPUPage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'Motherboard',
      route : MotherboardPage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'RAM',
      route : RAMPage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'Storage',
      route : StoragePage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'Case',
      route : CasePage(),
      icon : Icons.person,
    ),

    Ui(
      hardware_name : 'PowerSupply',
      route : PowerSupplyPage(),
      icon : Icons.person,
    ),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware List"),
      ),

      body: ListView.builder(
        itemCount: hardwarepart_list.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => hardwarepart_list[index].route),
              );
            },

            child: Padding(
              padding: const EdgeInsets.all(16.0),
                child: Row(
                 children: [
                  Icon(hardwarepart_list[index].icon),
                   SizedBox(width : 16.0),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         hardwarepart_list[index].hardware_name,
                         style: TextStyle(fontSize: 20.0),
                       ),
                       SizedBox(height: 8.0),
                     ],
                   )
                 ],
              )
            ),
          );
        },



      )
    );

  }
}
