import 'package:areabook_home_flutter/calendar_tab.dart';
import 'package:areabook_home_flutter/sync.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1; // Calendar tab selected by default

  final List<Widget> pages = [
    Center(child: Text("Home")),
    CalendarTab(),             // <-- Your calendar here
    Center(child: Text("People")),
    SyncPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],   // <-- NAV CONTROLS SCREEN
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color:  Color.fromARGB(255, 171, 175, 175),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 247, 248, 248),
          selectedItemColor: Color.fromARGB(255,0,48,87),
          unselectedItemColor: Color.fromARGB(255,171, 175, 175),
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'People'),
            BottomNavigationBarItem(icon: Icon(Icons.sync), label: 'Sync'),
          ],
        ),
      ),
    );
  }
}
