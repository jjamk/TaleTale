import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/page/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 1;
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
      case 1:
        return Home();
      case 2:
    }
    return Container();
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          "assets/svg/${iconName}.svg",
          width: 33,
          color: Colors.grey,
        ),
      ),
      activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}.svg",
            width: 33,
            color: Color.fromARGB(255, 138, 43, 43),
          )),
      label: label,
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      currentIndex: _currentPageIndex,
      selectedItemColor: Colors.black,
      selectedFontSize: 12,
      items: [
        _bottomNavigationBarItem("ticket", "예매확인"),
        _bottomNavigationBarItem("home", "홈"),
        _bottomNavigationBarItem("survey", "수요조사"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
