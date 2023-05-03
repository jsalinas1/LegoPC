
import 'package:flutter/material.dart';
import '../pages/buildpcpage.dart';
import 'package:path_provider/path_provider.dart';


Future main() async{
  runApp(MyApp());
}

enum hardware {CPU, GPU, Motherboard, RAM, Storage, Case, PowerSupply}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
        )//PCBuilder(), // Test

    );
  }
}

class HomePage extends StatelessWidget {

  late TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void submit(){
      Navigator.of(context).pop();
    }

    Future enterUserProf() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Build Name Profile'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter the name of this profile',
            ),
            controller: _controller,
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: submit,

            ),

            TextButton(
              child: Text('Cancel'),
              onPressed: () {},
            )

          ],
        )
    );





    return Scaffold(
      appBar: AppBar(
        title: Text('Lego PC Builder'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                //enterUserProf();
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Build Name Profile'),
                      content: TextField(

                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Enter the name of this profile',
                        ),
                        controller: _controller,
                      ),
                      actions: [
                        TextButton(
                          child: Text('SUBMIT'),
                          onPressed: (){
                            Navigator.of(context).pop();
                            print(_controller.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PCBuilder()));
                            
                          },

                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            onPressed: Navigator.of(context).pop();
                          },
                        )

                      ],
                    )
                );

                  ;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(6,6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6,-6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    )
                  ],
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Create New Build',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => PCBuilder()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(6,6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6,-6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    )
                  ],
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'Current Build',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PCBuilder()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(6,6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6,-6),
                      blurRadius: 15,
                      spreadRadius: 4,
                    )
                  ],
                  color: Colors.orange,
                ),
                child: Center(
                  child: Text(
                    'Search all parts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
