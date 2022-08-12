// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/login/signin.dart';
import 'package:travel_app/profile/profile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({ Key? key, required this.profile }) : super(key: key);

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
        child: Form(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: makeWidgets(widget.profile),
        ),
      ),
      ),
    );
  }

  List<Widget> makeWidgets(Profile profile) {
    List<Widget> widgets = [];
    TextEditingController foodController = TextEditingController(), animalController = TextEditingController();
    foodController.text = profile.food;
    animalController.text = profile.animal;
    widgets.add(
      CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl
        ),
        radius: 30,
        backgroundColor: Colors.transparent,
      )
    );
    widgets.add(const SizedBox(height: 20,));
    widgets.add(const Text(
      'Name',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black54 
      ),
      ));
    widgets.add(const SizedBox(height: 10,));
    widgets.add(Text(
      profile.name,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
    ));
    widgets.add(const SizedBox(height: 20,));
    widgets.add(const Text(
      'EMAIL',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black54,
        fontSize: 10
      ),
    ));
    widgets.add(const SizedBox(height: 10,));
    widgets.add(Text(
      profile.email,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
      ));
    widgets.add(const SizedBox(height: 20,));
    widgets.add(const Text(
      'About Food',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
    ));
    widgets.add(const SizedBox(height: 10,));
    widgets.add(TextField(
      controller: foodController,
      maxLines: 3,
      decoration: const InputDecoration(
        hintText: 'What\'s about you food style'
      ),
    ));
    widgets.add(const SizedBox(height: 20,));
    widgets.add(const Text(
      'About Animal',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black54
      ),
      ));
    widgets.add(const SizedBox(height: 10,));
    widgets.add(TextField(
      controller: animalController,
      maxLines: 3,
      decoration: const InputDecoration(
        hintText: 'What Animals do you like'
      ),
    ));
    widgets.add(const SizedBox(height: 40,));
    widgets.add(
      CupertinoButton.filled(
        child: const Text('Save'), 
        onPressed: () {
          profile.food = foodController.text;
          profile.animal = animalController.text;
          _showSavedDialog(context);
        }
      )
    );
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

