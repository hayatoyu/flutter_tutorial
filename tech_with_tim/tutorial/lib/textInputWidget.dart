import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {

  final Function(String) callback;
  TextInputWidget(this.callback);
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {

  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }
  
  @override
  Widget build(BuildContext context) {
    return 
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.message),
          labelText: "Type a message:",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            splashColor: Colors.blue,
            tooltip: "Post Message",
            onPressed: this.click,
          )
        ),
      );
  }
}