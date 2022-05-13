import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:works_with_tab/apihelper.dart';
import 'dart:developer' as developer;

class Profile_MySQL {
  int id = 0;
  late String userId,email,name,like,dislike;

  Profile_MySQL(this.userId,this.email,this.name);

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return this.id;
  }

  void setUserId(String userid) {
    this.userId = userid;
  }

  String getUserId() {
    return this.userId;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getEmail() {
    return this.email;
  }

  void setName(String name) {
    this.name = name;
  }

  String getName() {
    return this.name;
  }

  void setLike(String like) {
    this.like = like;
  }

  String getLike() {
    return this.like;
  }

  void setDislike(String dislike) {
    this.dislike = dislike;
  }

  String getDislike() {
    return this.dislike;
  }

  Future<List<Profile_MySQL>> Get_All() async {
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: 'api/AppAPI/users/query'
    );
    var response = await RaiseRequest("get", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Profile_MySQL("", "", "").createFromJsonList(responseBody);
    } else {
      developer.log(
        "Query All Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
        return [];
    }
    
  }

  Future<Profile_MySQL> Select_By_Email(String email) async {
    Map<String,dynamic> data = {
      'email' : email
    };
    Uri uri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/users/query/email',
      queryParameters: data
    );
    var response = await RaiseRequest("post", uri);
    if(response!.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Profile_MySQL("", "", "").createFromJson(responseBody);
    } else {
      // 應該要提示失敗或錯誤訊息
      developer.log(
        "Query Failed with email = " + email,
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Profile_MySQL("", email, "");
    }
  }

  Future<Profile_MySQL> Add_New_Profile(Profile_MySQL p) async {
    Uri uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/users/insert'
      );
    var response = await RaiseRequestPostObject(uri, p);
    if(response!.statusCode == 200) {
      return Profile_MySQL("","","").createFromJson(response.body);
    } else {
      // 應該要提示失敗或錯誤訊息
      developer.log(
        "Insert Failed",
        time: DateTime.now(),
        stackTrace: StackTrace.current
      );
      return Profile_MySQL("", "", "");
    }
  }

  Future<Profile_MySQL> Update_Profile(int id, Profile_MySQL p) async {
    Uri uri = Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: 'api/AppAPI/users/update/' + p.getId().toString()
      );
    var response = await RaiseRequestPostObject(uri, p);
    if(response!.statusCode == 200) {
      return Profile_MySQL("", "", "").createFromJson(response.body);
    } else {
      // 應該要提示失敗或錯誤訊息
      developer.log(
        "Update Failed with id = " + id.toString(),
        time: DateTime.now(),
        stackTrace: StackTrace.current
        );
      return p;
    }
  }

  Future<Profile_MySQL> SaveProfile(Profile_MySQL p) async {
    Profile_MySQL newP = Profile_MySQL("","","");
    if(this.id > 0) {
      newP = await Update_Profile(this.id,p);
    } else {
      newP = await Add_New_Profile(p);
    }
    return newP;
  }

  void Delete_Profile(Profile_MySQL p) async {
    // It should not delete the Profile
  }

  Profile_MySQL createFromJson(String jsonString) {
    Map<String,dynamic> data = jsonDecode(jsonString);
    Profile_MySQL profile = new Profile_MySQL("", "", "");
    profile.setId(data['id']);
    profile.setEmail(data['email']);
    profile.setName(data['name']);
    profile.setUserId(data['userid']);
    profile.setLike(data['like']);
    profile.setDislike(data['dislike']);
    return profile;
  }

  List<Profile_MySQL> createFromJsonList(String jsonString) {
    List<Profile_MySQL> profileList = [];
    var list = jsonString as List;
    list.map((e) => {
      profileList.add(createFromJson(e))
    });
    return profileList;
  }

  Map<String,dynamic> toJson() {
    return {
      'id' : this.getId().toString(),
      'email' : this.getEmail(),
      'name' : Uri.encodeComponent(this.getName()),
      'userid' : this.getUserId(),
      'like' : this.getLike(),
      'dislike' : this.getDislike()

    };
  }

}