import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({Key? key, required this.size, required this.icon, required this.text, required this.controller, required this.type, required this.obscure}) : super(key: key);
  final Size size;
  final Icon icon;
  final String text;
  final TextInputType type;
  final TextEditingController controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        controller: controller!,
        cursorColor: Colors.deepPurpleAccent,
        keyboardType: type,
        decoration: InputDecoration(
            icon: icon!,
            hintText: text!,
            border: InputBorder.none
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a ' + text;
          }
          return null;
        },
      ),
    );
  }
}


class InputContainer extends StatelessWidget {
  const InputContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade300.withAlpha(500),
        ),

        child: child
    );
  }
}


