import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:works_with_tab/database.dart';

@JsonSerializable()
class Profile {
  
  late DatabaseReference _id;
  String? userId;  // related to Google UserId
  String? likes;
  String? dislikes;  // String is the key and the Set includes all possible value
  //String value;

  DatabaseReference? getId() {
    return _id;
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void setLikes(String likes) {
    this.likes = likes;
  }

  void setDisLikes(String dislikes) {
    this.dislikes = dislikes;
  }

  void update() {
    updateProfile(this,this._id);
  }

  Profile(String? userId,String? likes,String? dislikes) {
    
    this.userId = userId;
    this.likes = likes;
    this.dislikes = dislikes;
  }

  Map<String, dynamic> toJson() {
    var temp = new Map<String,dynamic>();
    //temp.putIfAbsent("_id", () => this._id);
    temp.putIfAbsent("userId", () => this.userId);
    temp.putIfAbsent("likes", () => this.likes);
    temp.putIfAbsent("dislikes", () => this.dislikes);
    return temp;
  }

}

List<Profile> createProfile(DataSnapshot dataSnapshot) {

    List<Profile> profiles = [];

    if(dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key,value) {
        Profile profile = new Profile(value["userId"], value["likes"], value["dislikes"]);
        profile.setId(db.child('profile/' + key));
        profiles.add(profile);
      });
    }
    
    return profiles;
  }
