import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../models/Ui.dart';
import '../pages/cpupage.dart';
import '../pages/gpupage.dart';
import '../pages/rampage.dart';
import '../pages/motherboardpage.dart';
import '../pages/powersupplypage.dart';
import '../pages/storagepage.dart';
import '../pages/casepage.dart';
import '../models/cpu.dart';
import '../models/gpu.dart';

void main() => runApp(MyApp());

enum hardware {CPU, GPU, Motherboard, RAM, Storage, Case, PowerSupply}



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

  ///Helpful sites
  ///CPU World
  ///
  ///
  ///
  ///
  ///




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
    //print(result);

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));

    if(result != null)
      setState(() {
        hardwarepart_list[index].setName('$result');
      });


  }

  int myReference = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware List\t\t\t\t "),
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



      )
    );

  }
}


// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CpuModel {
//   final String name;
//   final String socket;
//
//   CpuModel({required this.name, required this.socket});
//
//   factory CpuModel.fromJson(Map<String, dynamic> json) {
//     return CpuModel(
//       name: json['name'],
//       socket: json['socket'],
//     );
//   }
// }
//
// // class CpuSearch {
// //   static Future<CpuModel?> search(String query) async {
// //     final response = await http.get(Uri.parse('https://www.cpu-world.com/api/search-api.php?search=${Uri.encodeComponent(query)}&fields=name,socket'));
// //
// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);
// //       final results = List<Map<String, dynamic>>.from(data['result']);
// //
// //       final models = results.map((result) => CpuModel.fromJson(result)).toList();
// //
// //       return models.firstWhere((model) => model.name.toLowerCase().contains(query.toLowerCase()), orElse: () => null);
// //     } else {
// //       return null;
// //     }
// //   }
// // }
