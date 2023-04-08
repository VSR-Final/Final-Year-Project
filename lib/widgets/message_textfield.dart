import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Type your Message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              String message = _controller.text;
              _controller.clear();
              FirebaseDatabase.instance
                  .ref()
                  .child('users')
                  .child(widget.currentId)
                  .child('messages')
                  .child(widget.friendId)
                  .child('chats')
                  .push()
                  .set({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now().toString(),
              }).then((value) {
                FirebaseDatabase.instance
                    .ref()
                    .child('users')
                    .child(widget.currentId)
                    .child('messages')
                    .child(widget.friendId)
                    .push()
                    .set({
                  'last_msg': message,
                });
              }).catchError((error) {
                print('Error sending message: $error');
              });

              await FirebaseDatabase.instance
                  .ref()
                  .child('users')
                  .child(widget.friendId)
                  .child('messages')
                  .child(widget.currentId)
                  .child("chats")
                  .push()
                  .set({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now().toString(),
              }).then((value) {
                FirebaseDatabase.instance
                    .ref()
                    .child('users')
                    .child(widget.friendId)
                    .child('messages')
                    .child(widget.currentId)
                    .push()
                    .set({"last_msg": message});
              });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
