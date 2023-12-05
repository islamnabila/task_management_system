import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/progress_task_screen.dart';
import 'package:task_manager_practice/Style/style.dart';

import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen =[
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          _selectedIndex = index;
          setState(() {

          });
        },

        selectedItemColor: colorGreen,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle), label: "In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.beenhere_rounded), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancelled")
        ],
      ),
    );
  }
}
