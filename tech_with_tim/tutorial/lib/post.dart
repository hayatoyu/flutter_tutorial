import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tutorial/database.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  DatabaseReference? _id;

  Post(this.body,this.author);

  void likePost(User user) {
    if(this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    this.update();
  }
  void setId(DatabaseReference id) {
    this._id = id;
  }
  void update() {
    updatePost(this, this._id!);
  }
  Map<String,dynamic> toJson() {
    return {
      'author':this.author,
      'usersLiked':this.usersLiked.toList(),
      'body':this.body
    };
  }
}

Post createPost(json) {
  Map<String,dynamic> attributes = {
    'author':'',
    'usersLiked':[],
    'body':''
  };
  json.forEach((key,value) => {
    attributes[key] = value
  });
  Post post = new Post(attributes['body'], attributes['author']);
  post.usersLiked = Set.from(attributes['usersLiked']);
  return post;
}