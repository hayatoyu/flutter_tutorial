// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
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
      const Text(
        'Activity Name',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      )
    );
    list.add(
      TextField(
        controller: titleController,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center
      )
    );
    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          const Text('Is Public'),
          Switch(
            value: widget.activity.isPublic, 
            onChanged: (value) {
              setState(() {
                widget.activity.isPublic = value;
              });
            },
            activeColor: Colors.green,
            activeTrackColor: Colors.lightGreenAccent,
          )
        ],
      )
    );
    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          const Text('Other People Can Raise Events'),
          Switch(
            value: widget.activity.canRaiseLeisure, 
            onChanged: (value) {
              setState(() {
                widget.activity.canRaiseLeisure = value;
              });
            },
            activeColor: Colors.green,
            activeTrackColor: Colors.lightGreenAccent,
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