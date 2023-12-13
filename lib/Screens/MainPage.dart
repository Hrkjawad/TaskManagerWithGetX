import 'package:flutter/material.dart';
import 'package:TaskManagerWithGetX/Screens/CanceledPage.dart';
import 'package:TaskManagerWithGetX/Screens/ComplatePage.dart';
import 'package:TaskManagerWithGetX/Screens/NewTaskPage.dart';
import 'package:TaskManagerWithGetX/Screens/ProgressPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskPage(),
    ComplatePage(),
    CanceledPage(),
    ProgressPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Canceled"),
          BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined), label: "Progress"),
        ],
      ),

    );
  }
}