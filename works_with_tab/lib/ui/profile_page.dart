
import 'package:works_with_tab/database.dart';
import 'package:works_with_tab/model/profile.dart';
import 'package:flutter/material.dart';

import 'signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var profile = new Profile("", "", "");
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
                onPressed: () {
                  //profile = new Profile(userId, likeController.text, dislikeController.text);
                  profile.setLikes(likeController.text);
                  profile.setDisLikes(dislikeController.text);
                  saveProfile(profile);
                  getCurrentProfile(userId);
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
    getCurrentProfile(userId);
  }

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
  }


}
