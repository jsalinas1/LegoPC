

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/buildpcinfo.dart';
import 'dart:convert';

import '../models/specs.dart';

class BuildList extends StatefulWidget{
  //late CPU myCPU;

  BuildListH createState() => BuildListH();

}


class BuildListH extends State<BuildList>{


  CollectionReference rootNote = FirebaseFirestore.instance.collection("users");

  Future<void> _navigateAndSave(BuildContext context, Specs spec, String docname, String buildname) async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PCInfo(userSpec: spec,)));

    print('This: ${result}');

    createUser(docname: docname, strJSON: result, buildname: buildname);

  }

  Future createUser({required String docname, required String strJSON, required String buildname}) async{


    final docUser = FirebaseFirestore.instance.collection('users').doc(docname);
    final myDoc = await docUser.get();
    List tags = myDoc.data()!['user_buildlist'];
    print(buildname);


    final toJson = json.decode(strJSON);



    List<Map<String,dynamic>> t = [
      {
        'buildname' : buildname,
        'build' : toJson,
      }
    ];

    for(Map map in tags){
      if(map?.containsKey('buildname') ?? false){
        if(map!['buildname'] == buildname) {
          await docUser.update({
            'user_buildlist': FieldValue.arrayRemove([map]),
          });
          break;
        }
      }
    }



    await docUser.update({
      'user_buildlist' : FieldValue.arrayUnion(t),
    });

  }



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Build list'
        )
      ),
      body: StreamBuilder(
        stream: rootNote.snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('ERROR');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData) {
            final result = snapshot.data!.docs;
           // final test = result.map((e) => e.id); // Cannot deal with this, security risk
           // print(test);
           // final test2 = result[]
            final t = result[0].data() as Map<String, dynamic>;
            final buildList = t['user_buildlist'] as List;


            return ListView.builder(
              itemCount: buildList.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: () async {
                  //   final st = rootNote.doc(result[0].id); //////// THIS STEP IS CRUCIAL
                  //   final doc = await st.get();
                  //  // print(doc.data());
                  //   final myMap = doc.data() as Map<String, dynamic>;
                  //   final myList = myMap['user_buildlist'];
                  // //  print('Test: ${myList[0]}');

                    Specs spec = Specs.fromJson(buildList[index]['build']);
                    print(spec.CPU);

                    _navigateAndSave(context, spec,result[0].id,buildList[index]['buildname']);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 14.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                  '${buildList[index]['buildname']}',//result[index].id,
                                  style: TextStyle(fontSize: 20.0),
                                ),

                              ]
                          )
                        ],
                      )
                  ),
                );
              },
            );
          }
          else{
            print('No data, fetching..');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}