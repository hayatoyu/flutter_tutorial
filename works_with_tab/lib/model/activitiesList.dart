import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:works_with_tab/database.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivitiesList extends StatefulWidget {
  final List<Activity> list = [];
  
  @override
  _ActivitiesListState createState() => _ActivitiesListState();

}

class _ActivitiesListState extends State<ActivitiesList> {
  TextEditingController actNameController = new TextEditingController();
  bool isPublic = false;
  bool canRaise = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: this.widget.list.length,
          itemBuilder: (context, index) {
            var activity = this.widget.list[index];
            return Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    subtitle: Text(name),
                    title: Text(activity.title),
                  ))
                ],
              ),
              
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Activity',
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context));
        },
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text("Create New Activity"),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextField(
            controller: actNameController,
            decoration: new InputDecoration(hintText: "Enter Activity Name"),
          ),
          ListTile(
            title: const Text('Is the Activity public?'),
            trailing: CupertinoSwitch(
              value: isPublic,
              onChanged: (bool value) {setState(() {
                isPublic = value;
              });},
            ),
          ),
          ListTile(
            title: const Text('Can participants raise an event?'),
            trailing: CupertinoSwitch(
              value: canRaise,
              onChanged: (bool value) {
                setState(() {
                  canRaise = value;
                });
              },),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              var act = new Activity(userId, actNameController.text);
              act.setId(saveActivity(act));
              act.setIsPublic(isPublic);
              act.setCanRaise(canRaise);
              // should callback to ListView to renew the List
              getActivities(userId);
              // close window
              Navigator.of(context).pop();
            },
            child: Text("Add New Activity"))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getActivities(userId);
  }

  void getActivities(String userId) {
    this.widget.list.clear();
    selectActivities(userId).then((value) => {
      this.setState(() {
        if(value != null) {
          for(var act in value) {
            this.widget.list.add(act);
          }
        }
      })
    });
  }
}
