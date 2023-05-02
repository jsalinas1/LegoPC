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



        )
    );

  }
}
