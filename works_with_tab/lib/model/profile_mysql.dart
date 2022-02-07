import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
//import 'package:mysql1/mysql1.dart';
//import 'package:works_with_tab/database_mysql.dart';

class Profile_MySQL {
  int Id = 0;
  late String userId,email,name,like,dislike;

  Profile_MySQL(this.userId,this.email,this.name);

  void setId(int id) {
    this.Id = id;
  }

  int getId() {
    return this.Id;
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

  void Get_All() async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/users/query'
      )
    );
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print(responseBody);
  }

  Future<Profile_MySQL?> Select_By_Email(String email) async {
    var httpClient = HttpClient();
    Map<String,dynamic> data = {
      'email' : email
    };
    var response = await httpClient.postUrl(Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/users/query/email',
      queryParameters: data
    ));
    var responseBody = await response.close();
    print(responseBody);
  }

  Future<Profile_MySQL> Add_New_Profile(Profile_MySQL p) async {
    /*
    var conn = await MySqlConnection.connect(db_settings);
    await conn.query(Insert,[p.userId,p.email,p.name,p.like,p.dislike]).then((value) {
      p.setId(value.insertId!);
    });
    await conn.close();
    */
    return Profile_MySQL("","","");
  }

  Future<Profile_MySQL> Update_Profile(Profile_MySQL p) async {
    /*
    var conn = await MySqlConnection.connect(db_settings);
    await conn.query(Update,[p.userId,p.email,p.name,p.like,p.dislike,p.Id]).then((value) => {});
    await conn.close();
    */
    return Profile_MySQL("","","");
  }

  Future<Profile_MySQL> SaveProfile(Profile_MySQL p) async {
    Profile_MySQL newP = Profile_MySQL("","","");
    if(this.Id > 0) {
      newP = await Update_Profile(p);
    } else {
      newP = await Add_New_Profile(p);
    }
    return newP;
  }

  void Delete_Profile(Profile_MySQL p) async {
    /*
    var conn = await MySqlConnection.connect(db_settings);
    await conn.query(Delete,[p.Id]).then((value) => null);
    await conn.close();
    */
  }

}