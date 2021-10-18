import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:works_with_tab/model/equipment.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'package:works_with_tab/database.dart';

class Activity {
  DatabaseReference? Id;
  late String creatorId;
  List<Leisure> leisureEvents = [];
  late String title;
  bool isPublic = false;
  bool canRaiseLeisure = false;

  Activity(String creatorId,String title) {
    this.creatorId = creatorId;
    this.title = title;
  }

  void setId(DatabaseReference id) {
    this.Id = id;
  }

  void setCreator(String userId) {
    this.creatorId = userId;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setIsPublic(bool value) {
    this.isPublic = value;
  }

  void setCanRaise(bool value) {
    this.canRaiseLeisure = value;
  }

  void setLeisureEvents(List<Leisure> leisures) {
    this.leisureEvents = leisures;
  }

  void createLeisure(Leisure leisure) {
    if(!canRaiseLeisure) {
      // Only Creator can raise
      if(leisure.founder != creatorId) {
        return;
      }  
    }
    this.leisureEvents.add(leisure);
  }

  void update() {
    this.Id!.update(toJson());
  }

  Map<String,dynamic> toJson() {
    var map = {
      'creatorId' : this.creatorId,
      'title' : this.title,
      'isPublic' : this.isPublic,
      'canRaiseLeisure' : this.canRaiseLeisure,
      'leisureEvents' : jsonEncode(leisureEvents)
    };
    return map;
  }
}



class Leisure {
  late String leisureName;
  late String description;
  late String founder;
  bool isPublic = false;
  late DateTime startTime,endTime;
  int ageRestiction = -1;
  String? remark;
  late List<Equipment> requiredEquipment;
  late List<String> participants;

  Leisure(this.leisureName,this.description,this.founder,this.startTime,this.endTime);

  void setIsPublic() {
    isPublic = !isPublic;
  }

  void setAgeRestriction(int age) {
    ageRestiction = age;
  }

  void addEquipment(Equipment equipment) {
    this.requiredEquipment.add(equipment);
  }

  void addParticipant(String user) {
    participants.add(user);
  }

  void removeEquipment(String name) {
    requiredEquipment.removeWhere((element) => element.name == name);
  }

  void removeParticipants(String user) {
    participants.remove(user);
  }
  
}

List<Activity> createActivity(DataSnapshot dataSnapshot) {
  List<Activity> result = [];
  if(dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key,value) {
      Activity act = new Activity(value["creatorId"], value["title"]);
      act.setId(db.child('activities/' + key));
      act.setLeisureEvents(createLeisure(/*value["leisureEvents"]*/));
      result.add(act);
    });
  }
  return result;
}

List<Leisure> createLeisure() {
  List<Leisure> result = [];
  return result;
}