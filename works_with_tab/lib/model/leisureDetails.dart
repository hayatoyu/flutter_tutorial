import 'package:flutter/material.dart';
import 'package:works_with_tab/model/activity.dart';

class LeisureDetail extends StatefulWidget {
  final Leisure leisure;
  const LeisureDetail({ Key? key, required this.leisure }) : super(key: key);

  @override
  _LeisureDetailState createState() => _LeisureDetailState();
}

class _LeisureDetailState extends State<LeisureDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  void SendBack(BuildContext context) {
    Navigator.pop(context, this.widget.leisure);
  }
}