import 'package:flutter/cupertino.dart';
import '../components/event.dart';
import '../models/users.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ExerciseDetailPage extends StatefulWidget {
  Users patient;
  Event event;

  ExerciseDetailPage(this.patient, this.event);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage>{
  @override
  Widget build(BuildContext context){
    String? _imageUrl;

    FirebaseFirestore instance = FirebaseFirestore.instance;

    CollectionReference videoRef = FirebaseFirestore.instance
        .collection('exercises');


    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Detail'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: videoRef.where('exerciseID', isEqualTo: widget.event.exerciseID).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          '${data['name']}',
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                        SizedBox(height: 8.0),
                        Image.network(
                          data['downloadLink'],
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.contain,
                        ),
                      ],
                    );
                  }).toList(),
                );
            }
          }
      ),
    );
  }

}