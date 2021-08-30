import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Profile {
  
  late DatabaseReference _id;
  String? userId;  // related to Google UserId
  late Map<String,Set<String>> attrs;  // String is the key and the Set includes all possible value
  //String value;

  void setId(DatabaseReference id) {
    this._id = id;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void setMap(Map<String,Set<String>> map) {
    this.attrs = map;
  }

  Profile(String? userId,Map<String,Set<String>> attrs) {
    this.userId = userId;
    this.attrs = new Map<String,Set<String>>();
    for(var e in attrs.entries) {
      this.attrs[e.key] = e.value;
    }
  }

  void addAttr(String attr,String value) {
    if(this.attrs.containsKey(attr)) {
      if(!this.attrs[attr]!.contains(value)) {
        this.attrs[attr]!.add(value);
      }
    } else {
      this.attrs[attr] = new Set();
      this.attrs[attr]!.add(value);
    }
  }

  Profile fromJson(Map<String,dynamic> json) {
    attrs = new Map<String,Set<String>>();
    var attrsVal = json["attrs"] as Map<String,Set<String>>;
    for(var e in attrsVal.entries) {
      attrs[e.key] = e.value;
    }
    Profile profile = new Profile(json["userId"],attrs);
    return profile;
  }

  Map<String, dynamic> toJson() {
    var temp = new Map<String,dynamic>();
    temp.putIfAbsent("_id", () => this._id);
    temp.putIfAbsent("userId", () => this.userId);
    temp.putIfAbsent("attrs", () => [attrs.map((key, value) => MapEntry(key,value.toList()))]);
    return temp;
  }

}
