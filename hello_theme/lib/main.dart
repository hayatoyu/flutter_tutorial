import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appName = ' Customize Theme';
    
    return new MaterialApp(
      title: appName,
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightGreen[600],
        accentColor: Colors.orange[600]
      ),
      home: new MyHomePage(
        title: appName
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
  /*
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title)
      ),
      body: new Center(
        child: new Container(
          color: Theme.of(context).accentColor,
          child: new Text(
            '老嘰咕老，嘰咕老，嘰咕老老老，老嘰咕老肥雞',
            style: Theme.of(context).textTheme.headline6
          )
        )
      ),
      floatingActionButton: new Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.grey), 
        child: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.computer),
          )),
    );
  }
  */
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final url = 'https://www.google.com';
  void increment() {
    setState(() {
      _counter++;
    });
  }
  void openurl() {
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:'
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            )
          ]
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: openurl,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        ),
    );
  }
}


