import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vit_hostel_repo/pages/detail_mess.dart';
import 'package:vit_hostel_repo/pages/history_page.dart';
import 'package:vit_hostel_repo/pages/home_page.dart';
import 'package:vit_hostel_repo/pages/notification_manager.dart';
import 'package:vit_hostel_repo/pages/settings_page.dart';
import 'package:vit_hostel_repo/pages/cleaning_complaint.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.newIndex });

  final int newIndex;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;
  List<Widget> screens = [];

  @override
  void initState() {
    _currentIndex = widget.newIndex;
    screens = [
      const ScreenHome(),
      const NotificationManager(),
      const History(),
      const Settings(),
    ];
    super.initState();
  }

  void changeScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                const Color(0xffF7F8FA),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDAE8F5).withOpacity(1),
                const Color(0xffDBE9F6).withOpacity(1),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        child: screens[_currentIndex],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            tabBackgroundColor: const Color.fromARGB(31, 84, 81, 214),
            activeColor: const Color.fromARGB(255, 84, 81, 214),
            padding: const EdgeInsets.all(12),
            gap: 6,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: "Home",
                iconColor: Color.fromARGB(255, 84, 81, 214),
                textColor: Color.fromARGB(255, 84, 81, 214),
              ),
              GButton(
                icon: Icons.notifications,
                text: "Notifications",
                iconColor: Color.fromARGB(255, 84, 81, 214),
                textColor: Color.fromARGB(255, 84, 81, 214),
              ),
              GButton(
                icon: Icons.history_rounded,
                text: "History",
                iconColor: Color.fromARGB(255, 84, 81, 214),
                textColor: Color.fromARGB(255, 84, 81, 214),
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
                iconColor: Color.fromARGB(255, 84, 81, 214),
                textColor: Color.fromARGB(255, 84, 81, 214),
              )
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
