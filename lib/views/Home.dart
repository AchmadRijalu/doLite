import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/views/Spending_Page.dart';
import 'package:todolist_lite/views/Task_Page.dart';
import 'package:todolist_lite/views/Task_Page.dart';

class Home extends StatefulWidget {
  static final routeNames = "/";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavIndex = 0;

  List<BottomNavigationBarItem> _bottoNavbarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.task_alt_rounded,
        ),
        label: TaskPage.routeNames),
    BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on_rounded),
        label: SpendingPage.routeNames)
  ];

  List<Widget> _listPageWidget = [
    TaskPage(),
    SpendingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPageWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottoNavbarItems,
        currentIndex: _bottomNavIndex,
        onTap: (Selected) {
          setState(() {
            _bottomNavIndex = Selected;
          });
        },
      ),
    );
  }
}
