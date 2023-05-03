
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/buildpcpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import '../models/specs.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
  String s = '';



  Future createUser({required String docname, required String strJSON}) async{

    final docUser = FirebaseFirestore.instance.collection('users').doc(docname);

    final toJson = json.decode(strJSON);

    print(toJson);

    await docUser.set(toJson);

  }

  @override
  Widget build(BuildContext context) {



    Future<void> submit() async{
      if(_controller.text.isEmpty) {
        return; // Do nothing if user enter empty input, will work on later
      }
      s = _controller.text; /// Might run into a bug where s is null
      Navigator.of(context).pop();
      _controller.clear();
      print('I passed');
      print(s);

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PCBuilder()));

      // ScaffoldMessenger.of(context)
      // ..removeCurrentSnackBar()
      // ..showSnackBar(SnackBar(content: Text('${result}')));

      if(result != null){
        createUser(docname: s, strJSON: result);
        print('Sent');
      }

    }

    Future enterUserProf() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Build Name Profile'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter the name of this profile',
              errorBorder: InputBorder.none,
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
                            submit();

                            
                          },

                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            _controller.clear();
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
