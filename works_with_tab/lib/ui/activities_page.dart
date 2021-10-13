import "package:flutter/material.dart";
import 'package:works_with_tab/model/activitiesList.dart';
import 'package:works_with_tab/model/activity.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({ Key? key }) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return ActivitiesList(<Activity>[]);
  }
}

