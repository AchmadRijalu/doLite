import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/views/Spending_View.dart';
import 'package:todolist_lite/views/Task_View.dart';

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
        label: TaskView.routeNames),
    BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on_rounded), label: DoneView.routeNames)
  ];

  List<Widget> _listPageWidget = [TaskView(), DoneView()];
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
