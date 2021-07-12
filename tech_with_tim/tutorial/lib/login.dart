import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World!"),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "";
  TextEditingController controller = new TextEditingController();

  void click() {
    this.name = controller.text;

  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Type Your Name :",
              border: OutlineInputBorder(borderSide: BorderSide(width: 5,color: Colors.black)),
              suffixIcon: IconButton(
                icon: Icon(Icons.done),
                splashColor: Colors.blue,
                tooltip: "Submit",
                onPressed: this.click,
              )),
        ),
      ),
    );
  }
}
