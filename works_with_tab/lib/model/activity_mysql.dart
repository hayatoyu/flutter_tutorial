import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:works_with_tab/apihelper.dart';
import 'dart:developer' as developer;

import 'package:works_with_tab/model/activity.dart';

class Activity_MySQL {
  int id = 0;
  String creatorId = "",title = "";
  List<Leisure_MySQL> leisures = [];
  bool isPublic = false, canRaiseLeisure = false;

  Activity_MySQL(String creatorId, String title) {
    this.creatorId = creatorId;
    this.title = title;
  }

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return this.id;
  }

  void setCreatorId(String creatorId) {
    this.creatorId = creatorId;
  }

  String getCreatorId() {
    return this.creatorId;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getTitle() {
    return this.title;
  }

  void setIsPublic(bool ispublic) {
    this.isPublic = ispublic;
  }

  bool getIsPublic() {
    return this.isPublic;
  }

  void setCanRaiseLeisure(bool canraiseleisure) {
    this.canRaiseLeisure = canraiseleisure;
  }

  bool getCanRaiseLeisure() {
    return this.canRaiseLeisure;
  }

  void setLeisureEvents(Future<List<Leisure_MySQL>> leisures) async {
    this.leisures = await leisures;
  }

  List<Leisure_MySQL> getLeisureEvents() {
    return this.leisures;
  }

  void addLeisure(Leisure_MySQL leisure) {
    if(!canRaiseLeisure) {
      // Only Activity Raiser can add events
    }
    this.leisures.add(leisure);
  }

  Future<List<Activity_MySQL>> Get_All() async {
    Uri uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/query'
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query All Failed with statusCode = " + response.statusCode.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
  }

  Future<Activity_MySQL> Select_By_Id(int id) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/activity/query/' + id.toString()
    );
    
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with id " + id.toString() + ", statusCode = " + response.statusCode.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Activity_MySQL("", "");
    }
  }

  Future<List<Activity_MySQL>> Select_By_CreatorId(String creatorId) async {
    Map<String, dynamic> data = {
      "creatorId" : creatorId
    };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/activity/query/creatorId',
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query Failed with creatorId = " + creatorId + ", statusCode = " + response.statusCode.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return [];
    }
  }

  Future<Activity_MySQL> Update(int id, Activity_MySQL activity) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/activity/update/' + id.toString(),
    );
    var response = await RaiseRequestPostObject(uri, activity);
    if(response!.statusCode == 200) {
      return Activity_MySQL("", "").createFromJson(response.body);
    } else {
      developer.log(
        "Update Failed with id = " + id.toString() + ", statusCode = " + response.statusCode.toString(),
        name: "Update Activity Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return activity;
    }
  }

  Future<Activity_MySQL> Insert(Activity_MySQL act) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/activity/insert',
    );
    var response = await RaiseRequestPostObject(uri, act);
    if(response!.statusCode == 200) {
      return Activity_MySQL("", "").createFromJson(response.body);
    } else {
      developer.log(
        "Insert Failed : " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Insert Activity Failed",
        stackTrace: StackTrace.current
        );
      return act;
    }
  }

  void Delete(int id) async {
    Map<String,dynamic> data = {"id" : id};
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/activity/del/' + id.toString(),
      queryParameters: data
    );
    var response = await RaiseRequest("delete", uri);
    if(response!.statusCode == 200) {
      developer.log(
        "Delete Activity where id = " + id.toString() + " successfully",
        time: DateTime.now(),
        name: "Delete Activity OK",
        stackTrace: StackTrace.current
        );
    } else {
      developer.log(
        "Delete Activity where id = " + id.toString() + " failed with statusCode = " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Deleted Activity failed",
        stackTrace: StackTrace.current
        );
    }
  }

  Activity_MySQL createFromJson(String jsonString) {
    Map<String,dynamic> data = jsonDecode(jsonString);
    Activity_MySQL act = new Activity_MySQL("", "");
    act.setId(data['id']);
    act.setCreatorId(data['creatorId']);
    act.setTitle(data['title']);
    act.setIsPublic(data['isPublic']);
    act.setCanRaiseLeisure(data['canRaiseLeisure']);
    // Raise Another Query(By ActivityId) for leisures
    var leisures = Leisure_MySQL("", "",0).Select_By_ActivityId(id); 
    act.setLeisureEvents(leisures);
    return act;
  }

  List<Activity_MySQL> createFromJsonList(String jsonString) {
    List<Activity_MySQL> acts = [];
    var list = jsonString as List;
    list.map((e) => {
      acts.add(createFromJson(e))
    });
    return acts;
  }

  Leisure_MySQL createLeisureFromJson(String jsonString) {
    Map<String,dynamic> data = jsonDecode(jsonString);
    Leisure_MySQL leisure = new Leisure_MySQL("","",0);
    leisure.setId(data['id']);
    leisure.setActivityId(data['activityId']);
    leisure.setLeisureName(data['leisureName']);
    leisure.setDescription(data['description']);
    leisure.setFounder(data['founder']);
    leisure.setIsPublic(data['isPublic']);
    leisure.setStartTime(data['startTime']);
    leisure.setEndTime(data['endTime']);
    leisure.setAgeRestriction(data['ageRestriction']);
    leisure.setRemark(data['remark']);
    return leisure;
  }

  List<Leisure_MySQL> createLeisuresFromJson(String jsonString) {
    List<Leisure_MySQL> leisureList = [];
    var list = jsonString as List;
    list.map((e) => {leisureList.add(createLeisureFromJson(e))});
    return leisureList;
  }

  Map<String,dynamic> toJson() {
    return {
      "id" : this.getId(),
      "canRaiseLeisure" : this.getCanRaiseLeisure(),
      "creatorId" : this.getCreatorId(),
      "title" : Uri.encodeComponent(this.getTitle()),
      "isPublic" : this.getIsPublic()
    };
  }
}

class Leisure_MySQL {
  int id = 0;
  int activityId = 0;
  String leisureName = "", founder = "";
  String remark = "", description = "";
  bool isPublic = false;
  int ageRestriction = -1;
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

  Leisure_MySQL(this.leisureName,this.founder,this.activityId);

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return this.id;
  }

  void setActivityId(int id) {
    this.activityId = id;
  }

  int getActivityId() {
    return this.activityId;
  }

  void setLeisureName(String leisurename) {
    this.leisureName = leisurename;
  }

  String getLeisureName() {
    return this.leisureName;
  }

  void setFounder(String founder) {
    this.founder = founder;
  }

  String getFounder() {
    return this.founder;
  }

  void setDescription(String description) {
    this.description = description;
  } 

  String getDescription() {
    return this.description;
  }

  void setRemark(String remark) {
    this.remark = remark;
  }

  String getRemark() {
    return this.remark;
  }

  void setAgeRestriction(int age) {
    this.ageRestriction = age;
  }

  int getAgeRestriction() {
    return this.ageRestriction;
  }

  void setIsPublic(bool flag) {
    this.isPublic = flag;
  }

  bool getIsPublic() {
    return this.isPublic;
  }

  void setStartTime(DateTime starttime) {
    this.startTime = starttime;
  }

  DateTime getStartTime() {
    return this.startTime;
  }

  void setEndTime(DateTime endtime) {
    this.endTime = endtime;
  }

  DateTime getEndTime() {
    return this.endTime;
  }

  Future<List<Leisure_MySQL>> Get_All() async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/leisure/query'
    );
    
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      developer.log(
        "Query All Failed with statusCode = " + response.statusCode.toString(),
        name: "Query All Leisure Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
  }

  Future<List<Leisure_MySQL>> Select_By_ActivityId(int activityId) async {
    var data = {
      "activityId" : activityId
    };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/leisure/query/' + activityId.toString(),
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with activityId = " + activityId.toString() + ", statusCode = " + response.statusCode.toString(),
        name: "Query Leisure Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
  }

  Future<Leisure_MySQL> Select_By_Id(int id) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: 'api/AppAPI/leisure/query/' + id.toString()
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisureFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with leisure id = " + id.toString() + ", statusCode = " + response.statusCode.toString(),
        name: "Query Leisure Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Leisure_MySQL("", "", 0);
    }
  }

  Future<List<Leisure_MySQL>> Select_Leisure_By_Time(DateTime startTime,DateTime endTime) async {
    var data = {
      "startTime" : startTime,
      "endTime" : endTime
    };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: 'app/AppAPI/leisure/query/time',
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with startTime = " + startTime.toString() + " and endTime = " + endTime.toString()
        + ", statusCode = " + response.statusCode.toString(),
        name: "Query Leisure Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
        return [];
    }
  }

  Future<Leisure_MySQL> Update(int id,Leisure_MySQL leisure) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/leisure/update/' + id.toString()
    );
    var response = await RaiseRequestPostObject(uri, leisure);
    if(response!.statusCode == 200) {
      return Activity_MySQL("", "").createLeisureFromJson(response.body);
    } else {
      developer.log(
        "Update Failed with id = " + id.toString() + ", statusCode = " + response.statusCode.toString(),
        name: "Update Leisure Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return leisure;
    }
  }

  Future<Leisure_MySQL> Insert(Leisure_MySQL leisure) async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/leisure/insert',
    );
    var response = await RaiseRequestPostObject(uri, leisure);
    if(response!.statusCode == 200) {
      return Activity_MySQL("", "").createLeisureFromJson(response.body);
    } else {
      developer.log(
        "Insert Failed : " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Insert Leisure Failed",
        stackTrace: StackTrace.current
        );
      return leisure;
    }
  }

  void Delete(int id) async {
    Map<String,dynamic> data = {"id" : id};
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      path: '/api/AppAPI/leisure/del/' + id.toString(),
      queryParameters: data,
      port: 8800
    );
    
    var response = await RaiseRequest("delete", uri);
    if(response!.statusCode == 200) {
      developer.log(
        "Delete Activity where id = " + id.toString() + " successfully",
        time: DateTime.now(),
        name: "Delete Leisure OK",
        stackTrace: StackTrace.current
        );
    } else {
      developer.log(
        "Delete Activity where id = " + id.toString() + " failed, statusCode = " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Deleted Leisure failed",
        stackTrace: StackTrace.current
        );
    }
  }
  
  Map<String,dynamic> toJson() {
    return {
      "id" : this.getId(),
      "activityId" : this.getActivityId(),
      "ageRestriction" : this.getAgeRestriction(),
      "description" : Uri.encodeComponent(this.getDescription()),
      "startTime" : this.getStartTime(),
      "endTime" : this.getEndTime(),
      "founder" : this.getFounder(),
      "isPublic" : this.getIsPublic(),
      "leisureName" : Uri.encodeComponent(this.getLeisureName()),
      "remark" : Uri.encodeComponent(this.getRemark())
    };
  }
}