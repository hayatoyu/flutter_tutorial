// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:travel_app/activity/activity.dart';
import 'package:travel_app/leisure/leisuredetail.dart';


class ActivityDetail extends StatefulWidget {
  ActivityDetail({ Key? key, required this.activity }) : super(key: key);

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();

  late Activity activity;
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getActAttribute(),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Leisure',
        child: const Icon(Icons.add),
        onPressed: () {
          
        },
      ),
    );
  }

  List<Widget> getActAttribute() {
    List<Widget> list = [];
    TextEditingController titleController = TextEditingController();
    titleController.text = widget.activity.title;
    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'Activity Name',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: titleController,
              maxLines: 1,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      )
    );
    
    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          const Expanded(
            child: Text(
              'Is Public',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            flex: 2,
          ),
          Expanded(
            flex: 2,
            child: Switch(
              value: widget.activity.isPublic,
              onChanged: (value) {
                setState(() {
                  widget.activity.isPublic = value;
                });
              },
              activeColor: Colors.green,
              activeTrackColor: Colors.lightGreenAccent,
            ),
          )
        ],
      )
    );
    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          const Expanded(
            child: Text(
              'Participants Can Raise Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Switch(
              value: widget.activity.canRaiseLeisure, 
              onChanged: (value) {
                setState(() {
                  widget.activity.canRaiseLeisure = value;
                });
              },
              activeColor: Colors.green,
              activeTrackColor: Colors.lightGreenAccent,
            ),
            flex: 2,
          )
        ],
      )
    );
    // add Leisures
    list.addAll(makeLeisureList());
    // add Participants
    return list;
  }

  List<Widget> makeLeisureList() {

    List<Widget> leisures = [];
    for (var element in widget.activity.leisureEvents) {
        leisures.add(
          Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    subtitle: Text('Founder : ' + element.founder),
                    title: Text(element.leisureName),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => LeisureDetail(leisure: element)
                        )
                      );
                    },
                  )
                )
              ],
            ),
          )
        );
      }
    return leisures;
  }


}