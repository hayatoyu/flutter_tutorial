import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:travel_app/activity/activity.dart';
import 'package:travel_app/customwidgets/datetimepicker.dart';
import 'package:intl/intl.dart';

class LeisureDetail extends StatefulWidget {
  LeisureDetail({Key? key, required this.leisure}) : super(key: key);

  @override
  State<LeisureDetail> createState() => _LeisureDetailState();

  late Leisure leisure;
}

class _LeisureDetailState extends State<LeisureDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.leisure.leisureName),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getLeisureAttribute()),
      ),
    );
  }

  void _showPicker(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 250,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  List<Widget> getLeisureAttribute() {
    List<Widget> widgets = [];
    TextEditingController nameController = TextEditingController(),
        desController = TextEditingController(),
        remarkController = TextEditingController(),
        ageController = TextEditingController();
    nameController.text = widget.leisure.leisureName;
    desController.text = widget.leisure.description;
    remarkController.text = widget.leisure.remark;
    ageController.text = widget.leisure.ageRestriction.toString();

    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Event Name',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Description',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: TextField(
              controller: desController,
              maxLines: 1,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Age Restriction',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: TextField(
              controller: ageController,
              maxLines: 1,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Remark',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: TextField(
              controller: remarkController,
              maxLines: 3,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Founder',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: Text(
              widget.leisure.founder,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Is Public',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
            )),
        Expanded(
            flex: 2,
            child: Switch(
              value: widget.leisure.isPublic,
              onChanged: (value) {
                setState(() {
                  widget.leisure.isPublic = value;
                });
              },
              activeColor: Colors.green,
              activeTrackColor: Colors.lightGreenAccent,
            ))
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Start Time',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        Expanded(
            flex: 2,
            child: DatePickItem(
              children: <Widget>[
                CupertinoButton(
                    child: Text(
                      //'${widget.leisure.startTime.year}/${widget.leisure.startTime.month}/${widget.leisure.startTime.day} ${widget.leisure.startTime.hour}:${widget.leisure.startTime.minute}',
                      DateFormat('yyyy-MM-dd HH:mm').format(widget.leisure.startTime),
                      style: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => _showPicker(CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newDateTime) {
                            setState(() {
                              widget.leisure.startTime = newDateTime;
                            });
                          },
                        )))
              ],
            )),
      ],
    ));
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CupertinoButton.filled(
            child: const Text('Save'),
            onPressed: () {
              widget.leisure.leisureName = nameController.text;
              widget.leisure.description = desController.text;
              widget.leisure.ageRestriction = ageController.text as int;
              widget.leisure.remark = remarkController.text;
            })
      ],
    ));
    return widgets;
  }
}
