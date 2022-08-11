import 'package:flutter/material.dart';
import 'package:travel_app/activity/activityList.dart';
import 'package:travel_app/login/signin.dart';
import 'package:travel_app/profile/profile.dart';
import 'package:travel_app/profile/profile_screen.dart';

class LoggedPage extends StatefulWidget {
  const LoggedPage({ Key? key }) : super(key: key);

  @override
  State<LoggedPage> createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(profile: profile)
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Activity'),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ActivityList(profile: profile, list: list,)
                  )
                );
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Back to Home'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        
      ),
      body: const Center(
        child: Text('My Page'),
      ),
    );
  }
}