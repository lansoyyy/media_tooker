import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_tooker/screens/pages/freelancers/bookings_page.dart';
import 'package:media_tooker/screens/pages/messages_page.dart';
import 'package:media_tooker/screens/pages/notif_page.dart';
import 'package:media_tooker/screens/pages/profile_page.dart';

import 'home_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = box.read('user') == 'Client'
        ? [
            const HomeScreen(),
            const MessagesPage(),
            const NotifPage(),
            ProfilePage(id: FirebaseAuth.instance.currentUser!.uid)
          ]
        : [
            const HomeScreen(),
            const MessagesPage(),
            const BookingsPage(),
            const NotifPage(),
            ProfilePage(id: FirebaseAuth.instance.currentUser!.uid)
          ];
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        items: box.read('user') == 'Client'
            ? [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messages',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ]
            : [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messages',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline_outlined),
                  label: 'Bookings',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
      ),
    );
  }
}
