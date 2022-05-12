import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/query'
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJsonList(responseBody);
    } else {
      return [];
    }
  }

  Future<Activity_MySQL> Select_By_Id(int id) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/query/' + id.toString()
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJson(responseBody);
    } else {
      return Activity_MySQL("", "");
    }
  }

  Future<List<Activity_MySQL>> Select_By_CreatorId(String creatorId) async {
    Map<String, dynamic> data = {
      "creatorId" : creatorId
    };
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/query/creatorId',
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createFromJsonList(responseBody);
    } else {
      return [];
    }
  }

  Future<Activity_MySQL> Update(int id, Activity_MySQL activity) async {
    Map<String,dynamic> data = activity.toJson();
    var httpClient = HttpClient();
    var request = await httpClient.putUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/update/' + id.toString(),
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
       return Activity_MySQL("", "").createFromJson(responseBody);
    } else {
      developer.log(
        "Update Failed : " + response.statusCode.toString(),
        name: "Update Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return activity;
    }
  }

  Future<Activity_MySQL> Insert(Activity_MySQL act) async {
    Map<String,dynamic> data = act.toJson();
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/insert',
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
       return Activity_MySQL("", "").createFromJson(responseBody);
    } else {
      developer.log(
        "Insert Failed : " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Insert Failed",
        stackTrace: StackTrace.current
        );
      return act;
    }
  }

  void Delete(int id) async {
    Map<String,dynamic> data = {"id" : id};
    var httpClient = HttpClient();
    var request = await httpClient.deleteUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/activity/del/' + id.toString(),
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      developer.log(
        "Delete Activity where id = " + id.toString() + " successfully",
        time: DateTime.now(),
        name: "Delete OK",
        stackTrace: StackTrace.current
        );
    } else {
      developer.log(
        "Delete Activity where id = " + id.toString() + " failed",
        time: DateTime.now(),
        name: "Deleted failed",
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
      "title" : this.getTitle(),
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
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/leisure/query'
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      return [];
    }
  }

  Future<List<Leisure_MySQL>> Select_By_ActivityId(int activityId) async {
    var data = {
      "activityId" : activityId
    };
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/leisure/query/' + activityId.toString(),
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with activityId = " + activityId.toString(),
        name: "Query Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return [];
    }
  }

  Future<Leisure_MySQL> Select_By_Id(int id) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: 'api/AppAPI/leisure/query/' + id.toString()
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisureFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with leisure id = " + id.toString(),
        name: "Query Failed",
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
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: 'app/AppAPI/leisure/query/time',
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Activity_MySQL("", "").createLeisuresFromJson(responseBody);
    } else {
      developer.log(
        "Query Failed with startTime = " + startTime.toString() + " and endTime = " + endTime.toString(),
        name: "Query Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
        return [];
    }
  }

  Future<Leisure_MySQL> Update(int id,Leisure_MySQL leisure) async {
    Map<String,dynamic> data = leisure.toJson();
    var httpClient = HttpClient();
    var request = await httpClient.putUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/leisure/update/' + id.toString(),
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
       return Activity_MySQL("", "").createLeisureFromJson(responseBody);
    } else {
      developer.log(
        "Update Failed : " + response.statusCode.toString(),
        name: "Update Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return leisure;
    }
  }

  Future<Leisure_MySQL> Insert(Leisure_MySQL leisure) async {
    Map<String,dynamic> data = leisure.toJson();
    var httpClient = HttpClient();
    var request = await httpClient.postUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/leisure/insert',
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
       return Activity_MySQL("", "").createLeisureFromJson(responseBody);
    } else {
      developer.log(
        "Insert Failed : " + response.statusCode.toString(),
        time: DateTime.now(),
        name: "Insert Failed",
        stackTrace: StackTrace.current
        );
      return leisure;
    }
  }

  void Delete(int id) async {
    Map<String,dynamic> data = {"id" : id};
    var httpClient = HttpClient();
    var request = await httpClient.deleteUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/leisure/del/' + id.toString(),
        queryParameters: data
      )
    );
    var response = await request.close();
    if(response.statusCode == 200) {
      developer.log(
        "Delete Activity where id = " + id.toString() + " successfully",
        time: DateTime.now(),
        name: "Delete OK",
        stackTrace: StackTrace.current
        );
    } else {
      developer.log(
        "Delete Activity where id = " + id.toString() + " failed",
        time: DateTime.now(),
        name: "Deleted failed",
        stackTrace: StackTrace.current
        );
    }
  }
  
  Map<String,dynamic> toJson() {
    return {
      "id" : this.getId(),
      "activityId" : this.getActivityId(),
      "ageRestriction" : this.getAgeRestriction(),
      "description" : this.getDescription(),
      "startTime" : this.getStartTime(),
      "endTime" : this.getEndTime(),
      "founder" : this.getFounder(),
      "isPublic" : this.getIsPublic(),
      "leisureName" : this.getLeisureName(),
      "remark" : this.getRemark()
    };
  }
}