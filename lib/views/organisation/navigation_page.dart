
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:get/get.dart';
import 'package:helping_hand/views/organisation/org_feed.dart';
import 'package:helping_hand/views/organisation/org_profile.dart';
import 'package:helping_hand/views/organisation/post_event_page.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    OrganisationProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationControllerOrg());
    print(controller.selectedIndex.value);
    if (isLoading) {
      return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(),
          ));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      //bottom navigation bar
      bottomNavigationBar: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.07,
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
              iconSize: 32,
              backgroundColor: const Color(0xffCDD4E0),
              //tabBackgroundColor: Colors.grey.shade400,
              //duration: Duration(milliseconds: 90),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              activeColor: Colors.white,
              tabs: [
                GButton(icon: Icons.home_rounded,
                //text: 'Home',
                onPressed: (){
                  loadUserData();
                },
                ),
                GButton(icon: Icons.feed_rounded,
                //text: 'Raise Fund',
                onPressed: (){
                  loadUserData();
                },
                ),
                GButton(icon: Icons.person_rounded,
                //text: 'Profile',
                onPressed: (){
                  loadUserData();
                },
                ),
              ], 
            ),
          ),
        ),
      ));
  }
}

class NavigationControllerOrg extends GetxController{
  final Rx<int> selectedIndex = 0.obs ;
  final screens = [
    const OrganisationFeed(),
    const PostEventPage(),
    const OrganisationProfilePage(),
  ];

  // Function to handle navigation based on a notification
  void handleNotificationNavigation(int index) {
    // Ensure the index is within the bounds of the screens list
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    }
  }
}