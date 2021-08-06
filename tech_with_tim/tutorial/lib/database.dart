import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

final dbReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = dbReference.child('posts/').push();
  id.set(post.toJson());
  return id;
}

void updatePost(Post post,DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllMessages() async {
  DataSnapshot dataSnapshot = await dbReference.child('posts/').once();
  List<Post> posts = [];
  if(dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key,value) {
      Post post = createPost(value);
      post.setId(dbReference.child('posts/' + key));
      posts.add(post);
    });
  }
  return posts;
}