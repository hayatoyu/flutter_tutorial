import 'package:flutter/material.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivitiesList extends StatefulWidget {
  
  final List<Activity> list;
  ActivitiesList(this.list);

  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.list.length,
      itemBuilder: (context,index) {
        var activity = this.widget.list[index];
        return Card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(activity.title),
                  subtitle: Text(name),
                )
              )
            ],
          ),
        );
      });
  }
}