import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:works_with_tab/apihelper.dart';
import 'dart:developer' as developer;

class Participant_MySQL {
  int activityId = 0, id = 0, leisureId = 0;
  String email = "", userid = "";

  void setId(int id) {
    this.id = id;
  }
  int getId() {
    return this.getId();
  }
  void setActivityId(int actId) {
    this.activityId = actId;
  }
  int getActivityId() {
    return this.activityId;
  }
  void setLeisureId(int leisureId) {
    this.leisureId = leisureId;
  }
  int getLeisureId() {
    return this.leisureId;
  }
  void setEmail(String email) {
    this.email = email;
  }
  String getEmail() {
    return this.email;
  }
  void setUserId(String userid) {
    this.userid = userid;
  }
  String getUserId() {
    return this.userid;
  }

  Map<String,dynamic> toJson() {
    return {
      "id" : this.getId(),
      "activityId" : this.getActivityId(),
      "leisureId" : this.getLeisureId(),
      "email" : this.getEmail(),
      "userid" : this.getUserId()
    };
  }

  Participant_MySQL createFromJson(String jsonString) {
    Map<String,dynamic> data = jsonDecode(jsonString);
    Participant_MySQL p = new Participant_MySQL();
    p.setId(data['id']);
    p.setActivityId(data['activityId']);
    p.setLeisureId(data['leisureId']);
    p.setEmail(data['email']);
    p.setUserId(data['userid']);
    return p;
  }

  List<Participant_MySQL> createFromJsonList(String jsonString) {
    List<Participant_MySQL> participants = [];
    var list = jsonString as List;
    list.map((e) => {
      participants.add(createFromJson(e))
    });
    return participants;
  }

  Future<Participant_MySQL> Get_Participant_By_Id(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/query/' + id.toString(),
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with id = " + id.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Participant_MySQL();
    }
    
  }

  Future<List<Participant_MySQL>> Get_Participant_By_UserId(String userid) async {
    var data = {
      "userid" : userid
    };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/query/userid',
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query Failed with userid = " + userid,
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
    
  }

  Future<List<Participant_MySQL>> Get_Participant_By_Email (String email) async {
    var data = { "email" : email };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      path: '/api/AppAPI/participant/query/email',
      port: 8800,
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query Failed with email = " + email,
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
  }

  Future<List<Participant_MySQL>> Get_Participant_By_ActivityId (String actId) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/query/activity/' + actId.toString(),
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query Failed with activityId = " + actId.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return [];
    }
  }

  Future<List<Participant_MySQL>> Get_Participant_By_LeisureId (String leisureId) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/query/leisure/' + leisureId.toString(),
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJsonList(responseBody);
    } else {
      developer.log("Query Failed with leisureId = " + leisureId.toString(),
      time: DateTime.now(),
      stackTrace: StackTrace.current
      );
      return [];
    }
  }

  Future<Participant_MySQL> Update(int id, Participant_MySQL p) async {
    var data = p.toJson();
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/update/' + id.toString(),
      queryParameters: data
    );
    var response = await RaiseRequest("put", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJson(responseBody);
    } else {
      developer.log(
        "Update Failed with id = " + id.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return p;
    }
  }

  Future<Participant_MySQL> Insert(Participant_MySQL p) async {
    var data = p.toJson();
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/insert',
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Participant_MySQL().createFromJson(responseBody);
    } else {
      developer.log(
        "Insert Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Participant_MySQL();
    }
  }

  void Delete(int id) async {
    var data = { "id" : id };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/participant/del/' + id.toString(),
      queryParameters: data
    );
    var response = await RaiseRequest("delete", uri);
    if(response!.statusCode == 200) {
      developer.log(
        "Delete Successfully with id = " + id.toString(),
        time: DateTime.now()
        );
    } else {
      developer.log(
        "Delete Failed with id = " + id.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
    }
  }
}