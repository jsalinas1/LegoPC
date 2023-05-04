

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/specs.dart';

class BuildList extends StatefulWidget{
  //late CPU myCPU;

  BuildListH createState() => BuildListH();

}


class BuildListH extends State<BuildList>{


  CollectionReference rootNote = FirebaseFirestore.instance.collection("users");

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