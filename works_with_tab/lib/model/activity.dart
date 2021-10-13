import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:works_with_tab/model/equipment.dart';
import 'package:works_with_tab/ui/signin.dart';

class Activity {
  late DatabaseReference Id;
  late String creatorId;
  late List<Leisure> leisureEvents;
  late String title;
  bool canRaiseLeisure = false;

  Activity(String creatorId,String title) {
    this.creatorId = creatorId;
    this.title = title;
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
}

class Leisure {
  late DatabaseReference activityId;
  late DatabaseReference Id;
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