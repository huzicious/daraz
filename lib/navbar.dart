import 'package:daraz_clone/Helpers/notification_service.dart';
import 'package:daraz_clone/screens/add_to_cart.dart';
import 'package:daraz_clone/screens/home_screen.dart';
import 'package:daraz_clone/screens/notifications_screen.dart';
import 'package:daraz_clone/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const NotificationScreen(),
    const AddToCart(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.token();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 35),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, size: 35),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, size: 35),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Change to fixed
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
