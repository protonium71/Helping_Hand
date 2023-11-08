
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:helping_hand/views/user/search_page.dart';
import 'package:helping_hand/views/user/user_feed.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _selectedIndex = 1;
  static List<Widget> _pages = <Widget>[
    UserFeed(),
    SearchPage(),
    // FundRaise(),
    // FeedNotification(),
    // ProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:
      _pages.elementAt(_selectedIndex)),
    

    
//bottom navigation bar
      bottomNavigationBar: Container(
        
        color: Color(0xffCDD4E0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: GNav(
            
            //gap between icon and the text
            gap: 8,
            backgroundColor: Color(0xffCDD4E0),
            tabBackgroundColor: Colors.grey.shade400,
            padding: EdgeInsets.all(14),
            tabs: [
              GButton(icon: Icons.home_rounded,
              text: 'Home',
              ),
              GButton(icon: Icons.search,
              text: 'Search',
              
              
              ),
              GButton(icon: Icons.monetization_on_rounded,
              text: 'Raise Fund',
              ),
              GButton(icon: Icons.notifications,
              text: 'Notifications',
              
              ),
              GButton(icon: Icons.person_rounded,
              text: 'Profile',
              ),
            ],
             selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            
          ),
        ),
      ));
  }
}