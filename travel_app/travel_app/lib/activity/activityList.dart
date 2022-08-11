// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/profile/profile.dart';
import 'activity.dart';
import 'package:travel_app/login/signin.dart';



class ActivityList extends StatefulWidget {
  ActivityList({ Key? key, required this.profile}) : super(key: key);

  late Profile profile;
  List<Activity> list = [];

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {

  TextEditingController actNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
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
                    ),
                  )
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
              builder: (BuildContext context) => _buildAddActivityDialog(context));
        },
      ),
    );
  }

  Widget _buildAddActivityDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Activity'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: actNameController,
            decoration: InputDecoration(
              hintText: 'Input Activity Name'
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            var act = Activity(userId, actNameController.text);
            act.setPublic(true);
            act.setCanRaise(true);
            setState(() {
              widget.list.add(act);
            });
            Navigator.of(context).pop();
          }, 
          child: Text("Add New Activity"))
      ],
    );
  }
}