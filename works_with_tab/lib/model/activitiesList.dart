import 'dart:html';

import 'package:flutter/material.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivitiesList extends StatefulWidget {
  
  final List<Activity> list = [];
  

  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: this.widget.list.length,
          itemBuilder: (context,index) {
            var activity = this.widget.list[index];
            return Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      subtitle: Text(name),
                      title: Text(activity.title),
                      )
                      )
                ],),
              );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Activity',
        child: const Icon(Icons.add),
        onPressed: null,
      ),
    );
    
  }

  @override
  void initState() {
    super.initState();
    getActivities(userId);
  }

  void getActivities(String userId) {
    
  }
}