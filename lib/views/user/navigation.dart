
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:helping_hand/views/user/search_page.dart';
import 'package:helping_hand/views/user/user_feed.dart';
import 'package:get/get.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  // int _selectedIndex = 1;
  // static List<Widget> _pages = <Widget>[
  //   const UserFeed(),
  //   SearchPage(),
  //   // FundRaise(),
  //   // FeedNotification(),
  //   // ProfileScreen(),
  // ];



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      backgroundColor: Colors.white,
       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//bottom navigation bar
      bottomNavigationBar: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.08,
          color: const Color(0xffCDD4E0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 13),
            child: GNav(  
              //gap between icon and the text
              
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.selectedIndex.value = index;
              },
              gap: 4,
              iconSize: 50,
              backgroundColor: const Color(0xffCDD4E0),
              //tabBackgroundColor: Colors.grey.shade400,
              //duration: Duration(milliseconds: 90),
              padding: const EdgeInsets.all(6),
              activeColor: Colors.white,
              tabs: const [
                GButton(icon: Icons.home_rounded,
                //text: 'Home',
                ),
                GButton(icon: Icons.search,
                //text: 'Search',
                
                
                ),
                GButton(icon: Icons.monetization_on_rounded,
                //text: 'Raise Fund',
                ),
                GButton(icon: Icons.notifications,
                //text: 'Notifications',
                
                ),
                GButton(icon: Icons.person_rounded,
                //text: 'Profile',
                ),
              ], 
            ),
          ),
        ),
      ));
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs ;
  final screens = [
    const UserFeed(),
    SearchPage(),
    Container(color: Colors.orange,),
    Container(color: Colors.purple,),
    Container(color: Colors.red,)
  ];
}