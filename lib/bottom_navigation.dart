import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: currentIndex == 0 ? Colors.green : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart,
              color: currentIndex == 1 ? Colors.green : Colors.grey),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task,
              color: currentIndex == 2 ? Colors.green : Colors.grey),
          label: 'Challenge',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,
              color: currentIndex == 3 ? Colors.green : Colors.grey),
          label: 'Settings',
        ),
      ],
    );
  }
}
