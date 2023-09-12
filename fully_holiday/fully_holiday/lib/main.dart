import 'package:flutter/material.dart';
import 'package:fully_holiday/area.dart';
import 'package:fully_holiday/homepage.dart';
import 'package:fully_holiday/settings.dart';
import 'package:fully_holiday/trip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fully Holiday',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        backgroundColor: Colors.indigo[50]
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeNavigation();
  }
}

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  static int _index = 0;

  PageController pageController = PageController(
    initialPage: _index,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomePage(),
        Area(),
        Trip(),
        Settings(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItem() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.amber[100],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Area',
        backgroundColor: Colors.amber[100],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books),
        label: 'My Trip',
        backgroundColor: Colors.amber[100],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
        backgroundColor: Colors.amber[100],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.more),
        label: 'More',
        backgroundColor: Colors.amber[100],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        items: buildBottomNavBarItem(),
        currentIndex: _index,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.cyan[100],
        onTap: (int index) {
          setState(() {
            _index = index;
            pageController.animateToPage(
              index, 
              duration: const Duration(milliseconds: 500), 
              curve: Curves.ease
            );
          });
        },
      ),
    );
  }
}
