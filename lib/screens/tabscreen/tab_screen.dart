import 'package:flutter/material.dart';

import '../../config/routes/routing_constants.dart';

import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/newsfeed/newsfeed_screen.dart';
import '../../screens/services/services_screen.dart';
import '../../screens/contacts/contacts_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _screens = [
    DashboardScreen(),
    NewsfeedScreen(),
    ServicesScreen(),
    ContactsScreen(),
  ];

  int _selectedScreenIndex = 0;
  var _appBarTitle = [
    'Dashboard',
    'Newsfeed',
    'Services',
    'Contacts',
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle[_selectedScreenIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, PreferencesScreenRoute);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.teal,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.inbox),
            label: 'Newsfeed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.connect_without_contact),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Contacts',
          ),
        ],
      ),
      body: _screens[_selectedScreenIndex],
    );
  }
}
