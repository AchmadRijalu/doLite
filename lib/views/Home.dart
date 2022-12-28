part of 'Pages.dart';

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
  ];

  List<Widget> _listPageWidget = [
    TaskPage(),
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
