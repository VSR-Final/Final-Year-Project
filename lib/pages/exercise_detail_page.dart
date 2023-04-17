import 'package:flutter/cupertino.dart';
import '../models/users.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseDetailPage extends StatefulWidget {
  Users patient;

  ExerciseDetailPage(this.patient);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage>{
  @override
  Widget build(BuildContext context){
    CollectionReference videoRef = FirebaseFirestore.instance
        .collection('exercises.dart');
    return StreamBuilder<QuerySnapshot>(
        stream: videoRef.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exercise: ${data['name']}',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),

                      ),
                      SizedBox(height: 8.0),
                      Image.network(data['downloadLink']),
                    ],
                  );
                }).toList(),
              );
          }
        }
    );
  }

}