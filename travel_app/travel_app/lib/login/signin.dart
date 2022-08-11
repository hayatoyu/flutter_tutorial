import 'package:travel_app/profile/profile.dart';
import 'package:travel_app/activity/activity.dart';



String userId = "hayato.yu";
String name = "Hayato";
String email = "hayato.yu@spectrumleaf.com";
String imageUrl = "";
Profile profile = Profile(userId, email, name);
List<Activity> list = [];

/*
PreferEvent evt1 = PreferEvent("Food", true, "Pork, Fish");
PreferEvent evt2 = PreferEvent('Animal', true, 'Rabbit');

Profile initProfile() {
  if(profile.list.isEmpty) {
    profile.addEvent(evt1);
    profile.addEvent(evt2);
  }
  return profile;
}
*/