import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:travel_app/profile/profile.dart';

class Activity {
  String creatorId = "", title = "";
  List<Leisure> leisureEvents = [];
  bool isPublic = false;
  bool canRaiseLeisure = false;

  Activity(this.creatorId,this.title);

  String getCreatorId() {
    return creatorId;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getTitle() {
    return title;
  }

  void setPublic(bool flag) {
    isPublic = flag;
  }

  bool getPublic() {
    return isPublic;
  }

  void setCanRaise(bool flag) {
    canRaiseLeisure = flag;
  }

  bool getCanRaise() {
    return canRaiseLeisure;
  }

  void setLeisureEvents(List<Leisure> list) {
    leisureEvents = list;
  }

  void addLeisure(Leisure leisure) {
    if(leisure.founder != creatorId) {
      return;
    }
    leisureEvents.add(leisure);
  }

  List<Leisure> getLeisureEvents() {
    return leisureEvents;
  }

  void removeLeisure(String name) {
    leisureEvents.removeWhere((element) => element.leisureName == name);
  }

  Leisure getLeisure(String name) {
    return leisureEvents.firstWhere((element) => element.leisureName == name);
  }


}

class Leisure {
  String leisureName = "", description = "", founder = "", remark = "";
  bool isPublic = false;
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  int ageRestriction = -1;
  List<Profile> participants = [];

  Leisure(this.leisureName,this.founder);

  void setLeisureName(String name) {
    leisureName = name;
  }

  String getLeisureName() {
    return leisureName;
  }

  void setFounder(String founder) {
    this.founder = founder;
  }

  String getFounder() {
    return founder;
  }

  void setDescription(String description) {
    this.description = description;
  }

  String getDescription() {
    return description;
  }

  void setRemark(String remark) {
    this.remark = remark;
  }

  String getRemark() {
    return remark;
  }

  void setPublic(bool flag) {
    isPublic = flag;
  }

  bool getPublic() {
    return isPublic;
  }

  void setStartTime(DateTime time) {
    startTime = time;
  }

  DateTime getStartTime() {
    return startTime;
  }

  void setEndTime(DateTime time) {
    endTime = time;
  }

  DateTime getEndTime() {
    return endTime;
  }

  void setAgeRestriction(int age) {
    ageRestriction = age;
  }

  int getAgeRestriction() {
    return ageRestriction;
  }

  void addParticipants(Profile p) {
    participants.add(p);
  }

  void removeParticipants(String id) {
    participants.removeWhere((element) => element.userId == id);
  }

  List<Profile> getParticipants() {
    return participants;
  }

  Profile getParticipant(String id) {
    return participants.firstWhere((element) => element.userId == id);
  }

}