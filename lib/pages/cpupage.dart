import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/cpu.dart';



class CPUPage extends StatefulWidget{
  //late CPU myCPU;

  CPUHPage createState() => CPUHPage(data: 'Test');//, myCPU: myCPU);

}

class CPUHPage extends State<CPUPage> {
  final String data;
  //CPU myCPU;
  CPUHPage({required this.data});


  List<dynamic> _items = [];

  List<dynamic> searchItem = [];


  Future<List<dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/cpu.json');

    return json.decode(jsonString);
  }

  Future<void> _navigateAndSave(BuildContext context, Map<String, dynamic> chosenOne) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CPUInfo(data: chosenOne)));


  }



  late TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchItem = _items.where((element) => element['name'].contains(value))
                        .toList();
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Search'
                ),
              )
          )
      ),
      body: FutureBuilder(
          future: loadJsonData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('ERROR LOADING JSON'),
              );
            } else {
              //List<dynamic> jsonData = snapshot.data;
              _items = snapshot.data;
              return ListView.builder(
                  itemCount: _controller!.text.isEmpty ? 20 : searchItem.length,
                  itemBuilder: (BuildContext context, int index) {

                    return InkWell(
                      onTap: (){
                        Map<String, dynamic> chosenData = _controller!.text.isEmpty ? _items[index] : searchItem[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CPUInfo(data : chosenData)));

                        //_navigateAndSave(context, chosenData);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.computer_outlined),
                            ),
                            SizedBox(width: 8,),
                            Text(
                                _controller!.text.isEmpty ? _items[index]['name'] : searchItem[index]['name'],
                                style: TextStyle(fontSize: 20)
                            ),
                          ],
                        ),
                      )
                    );
                  }
              );
            }
          }
      ),
    );
  }
}


class CPUInfo extends StatelessWidget{
  Map<String, dynamic> data;
  CPUInfo({Key? key, required this.data}) : super(key : key);

  late TextEditingController _controller = TextEditingController();

  String storedData = '';

  final double CPUInfoTextSize = 24;

  Widget build(BuildContext context) {
    print(storedData);
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name'])
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
                "Product Name: ${data['name']}",
                style: TextStyle(fontSize: CPUInfoTextSize),
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "MSRP Price: ${data['price_usd'].toString()}",
                style: TextStyle(fontSize: CPUInfoTextSize),
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "Core Count: ${data['core_count']}",
                style: TextStyle(fontSize: CPUInfoTextSize)
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "Core Clock: ${data['core_clock']}",
                style: TextStyle(fontSize: CPUInfoTextSize)
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "Boost Clock: ${data['boost_clock']}",
                style: TextStyle(fontSize: CPUInfoTextSize)
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "TDP: ${data['tdp']}",
                style: TextStyle(fontSize: CPUInfoTextSize)
            ),
            SizedBox(width: 12, height: 20,),
            Text(
                "Integrated Graphics: ${data['integrated_graphics'] == null ? 'None' : data['integrated_graphics']}",
                style: TextStyle(fontSize: CPUInfoTextSize)
            ),
            SizedBox(width: 12, height: 20,),
            IconButton(
              iconSize:72,
              icon: const Icon(Icons.add_circle),
              color: Colors.green,
              onPressed: (){
                Navigator.pop(context, );
              },
            ),
          ],
        ),
      )
    );
  }

}
/*
    required this.core_count,
    required this.core_clock,
    required this.boost_clock,
    required this.tdp,
    required this.integrated_graphics
 */