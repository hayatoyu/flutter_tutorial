import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget {

  String text = "";

  void setText(String text) {
    this.text = text;
  }
  
  @override
  _TextFormWidgetState createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 3,
    );
  }
}
