import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PowerSupplyPage extends StatefulWidget{
  //late CPU myCPU;

  PowerSupplyPageH createState() => PowerSupplyPageH(data: 'Test');//, myCPU: myCPU);

}

class PowerSupplyPageH extends State<PowerSupplyPage> {
  final String data;
  //CPU myCPU;
  PowerSupplyPageH({required this.data});


  List<dynamic> _items = [];

  List<dynamic> searchItem = [];


  Future<List<dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/power-supply.json');

    return json.decode(jsonString);
  }

  Future<void> _navigateAndSave(BuildContext context, Map<String, dynamic> chosenOne) async{
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PowerSupplyPageInfo(data: chosenOne)));
    save_Data = "$result";
    // ScaffoldMessenger.of(context)
    // ..removeCurrentSnackBar()
    //..showSnackBar(SnackBar(content: Text(save_Data)));
    if(result != null) Navigator.pop(context, "$result");

  }

  String save_Data = "";


  late TextEditingController _controller = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchItem = _items.where((element) => element['name'].contains(value)
                        || element['form_factor'].contains(value) || element['wattage'].contains(value))
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
                          //Navigator.push(
                          // context,
                          // MaterialPageRoute(builder: (context) => CPUInfo(data : chosenData)));
                          _navigateAndSave(context, chosenData);




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
                                  _controller!.text.isEmpty ?
                                  _items[index]['name'] + " " + _items[index]['form_factor'] + " " + _items[index]['wattage']
                                      : searchItem[index]['name']+ " " + searchItem[index]['form_factor'] + " " + searchItem[index]['wattage'],
                                  style: TextStyle(fontSize: 14)
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



class PowerSupplyPageInfo extends StatelessWidget{
  Map<String, dynamic> data;
  PowerSupplyPageInfo({Key? key, required this.data}) : super(key : key);

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
//"name": "NZXT H510", "rating": 4, "rating_count": 121, "price_usd": 66.98, "type": "ATX Mid Tower", "color": "White", "power_supply": null, "side_panel_window": "Tempered Glass", "external_5.25\"_bays": "0", "internal_3.5\"_bays": "2
              Text(
                "Product Name: ${data['name']}",
                style: TextStyle(fontSize: CPUInfoTextSize),
              ),
              SizedBox(width: 12, height: 20,),

              Text(
                "Form Factor: ${data['form_factor']}",
                style: TextStyle(fontSize: CPUInfoTextSize),
              ),
              SizedBox(width: 12, height: 20,),

              Text(
                "Efficiency Rating: ${data['efficiency_rating']}",
                style: TextStyle(fontSize: CPUInfoTextSize),
              ),
              SizedBox(width: 12, height: 20,),

              Text(
                "Price: ${data['price_usd'] == null ? 'Out of stock' : data['price_usd']}",
                style: TextStyle(fontSize: CPUInfoTextSize),
              ),
              SizedBox(width: 12, height: 20,),

              IconButton(
                iconSize:72,
                icon: const Icon(Icons.add_circle),
                color: Colors.green,
                onPressed: (){
                  Navigator.pop(context, data['name'] + " " + data['form_factor'] + " " + data['wattage']);
                },
              ),
            ],
          ),
        )
    );
  }

}

