import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:works_with_tab/model/equipment.dart';

class Activity {
  int id;
  List<String> participants;  // IDs of participants
  List<Leisure> leisureEvents;

  Activity(int id) {
    // Get from the database via id
    // If id is 0, create a new one
    if(id == 0) {
      participants = new List();
      leisureEvents = new List();
    } else {

    }
  }
}

class Leisure {
  int id;
  int activityId;
  String leisureName;
  String description;
  String founder;
  DateTime startTime,endTime;
  int ageRestiction;
  String remark;
  
  List<Equipment> requiredEquipment;
  List<String> participants;
}