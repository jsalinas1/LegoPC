

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

  Future<void> _navigateAndSave(BuildContext context, Specs spec, String docname) async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PCInfo(userSpec: spec,)));

    print('This: ${result}');

    createUser(docname: docname, strJSON: result);

  }

  Future createUser({required String docname, required String strJSON}) async{



    final docUser = FirebaseFirestore.instance.collection('users').doc(docname);

    final toJson = json.decode(strJSON);

    await docUser.update(toJson);

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
          else if(snapshot.hasData){
            final result = snapshot.data!.docs;


            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: () async {
                    final st = rootNote.doc(result[index].id); //////// THIS STEP IS CRUCIAL
                    final doc = await st.get();
                    Specs spec = Specs.fromJson(doc.data() as Map<String, dynamic>);

                    _navigateAndSave(context, spec,result[index].id);
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
                                  result[index].id,
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