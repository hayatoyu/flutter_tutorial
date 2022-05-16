import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:works_with_tab/database.dart';
import 'package:works_with_tab/model/activity_mysql.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivitiesList extends StatefulWidget {
  final List<Activity_MySQL> list = [];
  
  @override
  _ActivitiesListState createState() => _ActivitiesListState();

}

class _ActivitiesListState extends State<ActivitiesList> {
  TextEditingController actNameController = new TextEditingController();
  bool isPublic = true;
  bool canRaise = true;
  

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: actNameController,
            decoration: new InputDecoration(hintText: "Enter Activity Name"),
          ),
          
        ],
        
      ),
      actions: [
        TextButton(
            onPressed: () {
              var act = new Activity_MySQL(userId, actNameController.text);
              act.setId(widget.list.length);
              act.setIsPublic(isPublic);
              act.setCanRaiseLeisure(canRaise);
              setState(() {
                widget.list.add(act);  
              });
              //getActivities(userId);
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
    createActivities();
    //getActivities(userId);
  }

  createActivities() {
    Activity_MySQL act1 = Activity_MySQL("hayato", "test1");
    Activity_MySQL act2 = Activity_MySQL("hayato", "test2");
    act1.setId(1);
    act1.setIsPublic(true);
    act1.setCanRaiseLeisure(true);
    act2.setId(2);
    act2.setIsPublic(true);
    act2.setCanRaiseLeisure(false);
    widget.list.add(act1);
    widget.list.add(act2);
  }

  void getActivities(String userId) {
    this.widget.list.clear();
    selectActivities(userId).then((value) => {
      this.setState(() {
        if(value != null) {
          for(var act in value) {
            //this.widget.list.add(act);
          }
        }
      })
    });
  }
}
