import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bottom Nav Bar Animation",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.redAccent),
      ),
      home: const BottomNavBarDemo(),
    );
  }
}

class BottomNavBarDemo extends StatefulWidget {
  const BottomNavBarDemo({Key? key}) : super(key: key);

  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  static const List<Widget> _widgetOptions = <Widget>[
    Icon(CupertinoIcons.heart_fill, size: 100, color: Colors.redAccent),
    Icon(CupertinoIcons.add, size: 100, color: Colors.redAccent),
    Icon(CupertinoIcons.music_albums, size: 100, color: Colors.redAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Bottom Navigation Bar Demo"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const <Widget>[
          Icon(CupertinoIcons.heart_fill, size: 30, color: Colors.white),
          Icon(CupertinoIcons.add, size: 30, color: Colors.white),
          Icon(CupertinoIcons.music_albums, size: 30, color: Colors.white),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_pageIndex),
      ),
    );
  }
}
