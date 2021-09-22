import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:works_with_tab/model/equipment.dart';

class Activity {
  late int id;
  late List<String> participants;  // IDs of participants
  late List<Leisure> leisureEvents;

  Activity(int id) {
    // Get from the database via id
    // If id is 0, create a new one
    if(id == 0) {
      participants = [];
      leisureEvents = [];
    } else {
      // get from the database
    }
  }
}

class Leisure {
  int id = 0;
  int activityId = 0;
  String? leisureName;
  String? description;
  String? founder;
  DateTime? startTime,endTime;
  int ageRestiction = -1;
  String? remark;
  
  List<Equipment>? requiredEquipment;
  List<String>? participants;
}