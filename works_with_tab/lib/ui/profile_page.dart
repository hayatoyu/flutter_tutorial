
import 'package:works_with_tab/database.dart';
import 'package:works_with_tab/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:works_with_tab/model/profile_mysql.dart';

import 'signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var profile = new Profile_MySQL("", "", "");
  //var profile = new Profile_MySQL("", "", "");
  TextEditingController likeController = new TextEditingController();
  TextEditingController dislikeController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  radius: 30,
                  backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20,),
            Text(
              'NAME',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
            ),
            SizedBox(height: 10,),
            Text(
              name,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.bold
                ),
            ),
            SizedBox(height: 10,),
            Text(
              'EMAIL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black54
                ),
              ),
            SizedBox(height: 10,),
            Text(
              email,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.bold
                ),
            ),
            SizedBox(height: 20,),
            Text(
              'Like : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black54),
            ),
            TextField(
              controller: likeController,
              maxLines: 3,
              decoration: new InputDecoration(
                hintText: 'Enter anything you like'
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Dislike : ',
              style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            TextFormField(
              controller: dislikeController,
              maxLines: 3,
              decoration: new InputDecoration(
                hintText: 'Enter anything you don''t like'
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  //profile = new Profile_MySQL(userId, likeController.text, dislikeController.text);
                  profile.setEmail(email);
                  profile.setName(name);
                  profile.setUserId(userId);
                  profile.setLike(likeController.text);
                  profile.setDislike(dislikeController.text);
                  profile = await profile.SaveProfile(profile);
                  //profile.SaveProfile();
                  //getCurrentProfile(userId);
                  //getCurrentProfile(email,profile);
                },
                child: const Text('Submit'),
              ),
            )
          ],
        )
      )
    );
    
  }

  @override
  void initState() {
    super.initState();
    getCurrentProfile(email,profile);
    //likeController.text = profile.like;
    //dislikeController.text = profile.dislike;
  }

  void test() {
    new Profile_MySQL("", "", "").Get_All();
  }

  void getCurrentProfile(String email,Profile_MySQL profile) async {
    var p = await (Profile_MySQL("", "", "").Select_By_Email(email));
    if(p.getId() > 0) {
      profile.setId(p.getId());
      profile.setEmail(p.getEmail());
      profile.setName(p.getName());
      profile.setUserId(p.getUserId());
      profile.setLike(p.getLike());
      profile.setDislike(p.getDislike());
      likeController.text = profile.like;
      dislikeController.text = profile.dislike;
    } else {
      profile.setLike("");
      profile.setDislike("");
      profile.setName(name);
      profile.setUserId(userId);
      profile.setEmail(email);
    }
  }

  /*
  void getCurrentProfile(String userId) {
    
    selectProfile(userId).then((value) => {
      this.setState(() {
        if(value != null) {
          this.profile = new Profile(value.userId, value.likes, value.dislikes);
          this.profile.setId(value.getId()!);
          likeController.text = profile.likes ?? "";
          dislikeController.text = profile.dislikes ?? "";
        }
      })
    });
    
    /*
    profile.Select_By_UserId(userId).then((value) => {
      this.setState(() {
        if(value != null) {
          this.profile = value;
          likeController.text = profile.like;
          dislikeController.text = profile.dislike;
        }
      })
    });
    */
  }
  */


}
