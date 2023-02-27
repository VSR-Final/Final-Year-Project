import 'package:flutter/material.dart';

class ExcerciseTile extends StatelessWidget {

  const ExcerciseTile({Key? key, required this.text, required this.date}) : super(key: key);
  final String text;
  final String date;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(Icons.sports_gymnastics, color: Colors.deepPurpleAccent,),
          title: Text(text!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          subtitle: Text("due by " + date!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        ),
      ),
    );
  }
}
