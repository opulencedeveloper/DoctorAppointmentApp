import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';
import '../tabs/doctor_category_tab.dart';
import '../tabs/profile_tab.dart';
import '../tabs/chat_tab.dart';

class TabsScreen extends StatefulWidget {
   static const routeName = './tabs-routeName';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = const [
    HomeTab(),
    DoctorCategoryTab(),
    ChatTab(),
    ProfileTab(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        showUnselectedLabels: true,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
