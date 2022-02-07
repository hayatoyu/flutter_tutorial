import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class People {
  String name ,email="" ;
  List<People> family = [];

  People(this.name);

  People fromJson(Map<String,dynamic> body) {
    People p = new People(body["name"]);
    p.email = body["email"];
    List<People> familyList = json.decode(body["family"]).cast<List<People>>();
    for(var ppl in familyList) {
      p.family.add(ppl);
    }
    return p;
  }

  Map<String,dynamic> toJson() {
    return {
      'name' : name,
      'email' : email,
      'family' : family.map((e) => {
        'name' : e.name,
        'email' : e.email,
        'family' : e.family
      }).toList()
    };
  }

}