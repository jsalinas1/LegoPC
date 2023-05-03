

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/specs.dart';

class BuildList extends StatefulWidget{
  //late CPU myCPU;

  BuildListH createState() => BuildListH();

}


class BuildListH extends State<BuildList>{

  Stream<List<Specs>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=> Specs.fromJson(doc.data())).toList());

  Future<void> readDocs() async{
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users').get();
    List<DocumentSnapshot> docs = result.docs;
    print(docs[0].id);
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Build list'
        )
      ),
      body: StreamBuilder<List<Specs>>(
        stream: readUsers(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('ERROR');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData){
            final users = snapshot.data!;
            readDocs();


            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
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
                                  users[index].CPU,
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