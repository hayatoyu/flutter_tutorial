// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/login/signin.dart';
import 'package:travel_app/profile/profile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  late Profile profile;
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: makeWidgets(widget.profile),
          ),
        ),
      ),
    );
  }

  List<Widget> makeWidgets(Profile profile) {
    List<Widget> widgets = [];
    TextEditingController foodController = TextEditingController(),
        habitController = TextEditingController();
    foodController.text = profile.food;
    habitController.text = profile.habit;
    /*
    widgets.add(
      CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl
        ),
        radius: 30,
        backgroundColor: Colors.transparent,
      )
    );
    */
    widgets.add(const SizedBox(
      height: 20,
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            'Name',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text(
            profile.name,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          flex: 2,
        ),
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
          child: Text(
            'EMAIL',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text(
            profile.email,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          flex: 2,
        ),
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
          child: Text(
            'About Food',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          flex: 2,
        ),
        Expanded(
          child: TextField(
            controller: foodController,
            keyboardType: TextInputType.text,
            maxLines: 3,
            decoration: const InputDecoration(
                hintText:
                    'What do you like for food. Please tell us anything you concerned',
                hintStyle: TextStyle(color: Colors.black26, fontSize: 14)),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          flex: 2,
        ),
      ],
    ));
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            'About Habits',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          flex: 2,
        ),
        Expanded(
            child: TextField(
              controller: habitController,
              keyboardType: TextInputType.text,
              maxLines: 10,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              decoration: const InputDecoration(
                  hintText: 'Please tell us anything about your habit',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black26)),
            ),
            flex: 2),
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
            profile.food = foodController.text;
            profile.habit = habitController.text;
            _showSavedDialog(context);
          },
          alignment: Alignment.bottomRight,
        )
      ],
    ));
    return widgets;
  }

  void _showSavedDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Data Saved'),
        content: const Text('Saved Completed!'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
