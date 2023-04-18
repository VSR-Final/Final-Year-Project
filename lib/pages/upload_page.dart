import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyearproject/models/users.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:finalyearproject/components/upload_file.dart';
import 'package:finalyearproject/widgets/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:finalyearproject/components/rounded_input.dart';
import 'dart:io';

import '../main.dart';




class uploadPage extends StatefulWidget {
  
Users users;
uploadPage(this.users);
  @override
  State<uploadPage> createState() => _uploadPageState();
}
class _uploadPageState extends State<uploadPage> {
  UploadTask? task;
  File? file;

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context){
    final fileName = file != null ? basename(file!.path): 'No File Selected';



    return Scaffold(
      appBar: AppBar(
        title: Text('PhysioAssistant'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Exercise Name: '),
            SizedBox(height: 10,),
            TextFormField(
            controller: _nameController,
            cursorColor: Colors.deepPurpleAccent,
              decoration: InputDecoration(
                  icon: Icon(Icons.add),
                  hintText: 'Exercise Name',
              ),
            keyboardType: TextInputType.text,
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter exercise name';
              }
              return null;
            },
          ),
              SizedBox(height: 15,),
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox (height :8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      );
}

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async{
    FirebaseFirestore collection = FirebaseFirestore.instance;

    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseUpload.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.then((snapshot) {
      return snapshot;
    });
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download-Link: $urlDownload');

    var random = new Random();
        var exercise_uid = 'EX' + (random.nextInt(900000) + 100000).toString();

    collection
        .collection('exercises')
        .doc(exercise_uid)
        .set({
      'exerciseID': exercise_uid,
      'fileName': fileName,
      'name': _nameController.text,
      'physiotherapist': widget.users.name,
      'downloadLink': urlDownload,
      'physiotherapist_id': widget.users.uid,
    });

    
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot){
      if (snapshot.hasData){
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}
