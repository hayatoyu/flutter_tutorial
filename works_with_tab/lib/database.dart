import 'package:firebase_database/firebase_database.dart';
import 'package:works_with_tab/model/profile.dart';
import 'package:works_with_tab/ui/signin.dart';

final db = FirebaseDatabase.instance.reference();

DatabaseReference saveProfile(Profile profile) {
  if(profile.getId() != null) {
    profile.update();
    return profile.getId()!;
  } else {
    var id = db.child('profile/').push();
    id.set(profile.toJson());
    return id;
  }
}

void updateProfile(Profile profile,DatabaseReference id) {
  id.update(profile.toJson());
}

Future<Profile?> selectProfile(String userId) async {
  //var userData = await db.child('profile/').equalTo(userId).once();
  var userData = await db.child('profile/').once();
  Profile? profile;
  List<Profile> profiles = [];
  if(userData.value != null) {
    profiles = createProfile(userData);
    //profile.setId(db.child('profile/' + userData.key!));
  }
  for(var p in profiles) {
    if(p.userId == userId) {
      profile = p;
      profile.setId(p.getId()!);
      break;
    }
  }
  return profile;
}