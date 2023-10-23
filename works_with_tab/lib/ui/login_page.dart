
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:works_with_tab/ui/activities_page.dart';
import 'package:works_with_tab/ui/profile_page.dart';
import 'package:works_with_tab/ui/signin.dart';
import 'package:works_with_tab/main.dart';

final GlobalKey<NavigatorState> _navkey = GlobalKey<NavigatorState>();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class LoggedScreen extends StatefulWidget {
  const LoggedScreen({ Key? key }) : super(key: key);

  @override
  _LoggedScreenState createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> with SingleTickerProviderStateMixin {

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3,vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Profile",),
            Tab(text: "Activities",),
            Tab(text: "Calendar",)
          ],
        ),
      ),
      body: Navigator(
        key: _navkey,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              ProfilePage(),
              ActivitiesPage(),
              CellCalendar(
                daysOfTheWeekBuilder: (dayIndex) {
                  final labels = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      labels[dayIndex],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
/*
class LoggedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Profile'),
                Tab(text: 'Activities'),
                Tab(text: 'Calendar')
              ],
              
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              //FirstScreen(),
              ProfilePage(),
              //Text('Coming Soon 2'),
              ActivitiesPage(),
              CellCalendar(
                daysOfTheWeekBuilder: (dayIndex) {
                  final labels = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      labels[dayIndex],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  );
                },
              )
            ],
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
    );
  }
}
*/


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100]!, Colors.blue[400]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 30,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Like : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              ),
              SizedBox(height: 20,),
              Text('Dislike : ',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
                //color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                //elevation: 5,
                /*
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                */
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.grey,
      minimumSize: Size(88,36),
      padding: EdgeInsets.symmetric(horizontal:16),
      shape: const RoundedRectangleBorder(
        borderRadius:BorderRadius.all(Radius.circular(2))
      )
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          return BorderSide(); // Defer to the widget's default.
        },
      )
    );
    return OutlinedButton(
      style: outlineButtonStyle,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null && !result.isEmpty) {
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
              return LoggedScreen();
            },
            ),
            );
          }
        });
      },
      child: Text('Sign in with Google'),
    );
    /*
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
              return FirstScreen();
            },
            ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
    */
  }
}