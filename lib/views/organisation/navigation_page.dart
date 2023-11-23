
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:helping_hand/views/organisation/home_page.dart';
import 'package:get/get.dart';
import 'package:helping_hand/views/organisation/org_profile.dart';
import 'package:helping_hand/views/organisation/post_event_page.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    OrganisationProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationControlle());
    return Scaffold(
      backgroundColor: Colors.white,
       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//bottom navigation bar
      bottomNavigationBar: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.06,
          color: const Color(0xffCDD4E0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 0),
            child: GNav(  
              //gap between icon and the text
              
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.selectedIndex.value = index;
              },
              gap: 4,
              // iconSize: 80,
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
                // GButton(icon: Icons.person_rounded,
                // //text: 'Profile',
                // ),
              ], 
            ),
          ),
        ),
      ));
  }
}

class NavigationControlle extends GetxController{
  final Rx<int> selectedIndex = 0.obs ;
  final screens = [
    const HomePage(),
    OrganisationProfilePage(),
    const PostEventPage(),
    Container(color: Colors.orange,),
  ];
}