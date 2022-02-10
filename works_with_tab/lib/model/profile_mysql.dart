import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  Future<Profile_MySQL> Get_All() async {
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
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Profile_MySQL("", "", "").createFromJson(responseBody);
    } else {
      // 提示失敗或錯誤訊息
      return Profile_MySQL("", "", "");
    }
    
  }

  Future<Profile_MySQL> Select_By_Email(String email) async {
    var httpClient = HttpClient();
    Map<String,dynamic> data = {
      'email' : email
    };
    var request = await httpClient.postUrl(Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8800,
      path: '/api/AppAPI/users/query/email',
      queryParameters: data
    ));
    var response = await request.close();
    if(response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      return Profile_MySQL("", "", "").createFromJson(responseBody);
    } else {
      // 應該要提示失敗或錯誤訊息
      return Profile_MySQL("", email, "");
    }
  }

  Future<Profile_MySQL> Add_New_Profile(Profile_MySQL p) async {

    var response = await http.post(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: '/api/AppAPI/users/insert'
      ),
      headers: {
        'content-type' : 'application/json',
        'Accept' : 'application/json'
      },
      body: json.encode(p),
      encoding: Encoding.getByName('utf-8')
    );
    
    if(response.statusCode == 200) {
      return Profile_MySQL("","","").createFromJson(response.body);
    } else {
      // 應該要提示失敗或錯誤訊息
      return Profile_MySQL("", "", "");
    }
  }

  Future<Profile_MySQL> Update_Profile(Profile_MySQL p) async {
    
    var response = await http.post(
      Uri(
        scheme: 'http',
        host: '10.0.2.2',
        port: 8800,
        path: 'api/AppAPI/users/update/' + p.getId().toString()
      ),
      headers: {
        "Accept" : "application/json",
        "content-type" : "application/json"
      },
      body: json.encode(p),
      encoding: Encoding.getByName('utf-8')
    );
    if(response.statusCode == 200) {
      return Profile_MySQL("", "", "").createFromJson(response.body);
    } else {
      // 應該要提示失敗或錯誤訊息
      return p;
    }
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
      'id' : this.getId(),
      'email' : this.getEmail(),
      'name' : this.getName(),
      'userid' : this.getUserId(),
      'like' : this.getLike(),
      'dislike' : this.getDislike()

    };
  }

}