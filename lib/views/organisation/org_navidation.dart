
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:helping_hand/providers/organisation_provider.dart';
// import 'package:helping_hand/providers/user_provider.dart';
// import 'package:helping_hand/views/organisation/org_feed.dart';
// import 'package:helping_hand/views/organisation/org_profile.dart';
// import 'package:helping_hand/views/user/profile_page.dart';
// import 'package:helping_hand/views/user/search_page.dart';
// import 'package:helping_hand/views/user/notification_page.dart';
// import 'package:helping_hand/views/user/user_feed.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// class OrganisationNavigation extends StatefulWidget {
//   const OrganisationNavigation({super.key});

//   @override
//   State<OrganisationNavigation> createState() => _OrganisationNavigation();
// }

// class _OrganisationNavigation extends State<OrganisationNavigation> {

//   // int _selectedIndex = 1;
//   // static List<Widget> _pages = <Widget>[
//   //   const UserFeed(),
//   //   SearchPage(),
//   //   // FundRaise(),
//   //   // FeedNotification(),
//   //   // ProfileScreen(),
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     loadUserData();
//   }

//   loadUserData() async {
//     OrganisationProvider organisationProvider = Provider.of(context, listen: false);
//     await organisationProvider.refreshUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//        body: Obx(() => controller.screens[controller.selectedIndex.value]),
// //bottom navigation bar
//       bottomNavigationBar: Obx(
//         () => Container(
//           height: MediaQuery.of(context).size.height * 0.08,
//           color: const Color(0xffCDD4E0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 13),
//             child: GNav(  
//               //gap between icon and the text
              
//               selectedIndex: controller.selectedIndex.value,
//               onTabChange: (index) {
//                 controller.selectedIndex.value = index;
//               },
//               gap: 4,
//               iconSize: 50,
//               backgroundColor: const Color(0xffCDD4E0),
//               //tabBackgroundColor: Colors.grey.shade400,
//               //duration: Duration(milliseconds: 90),
//               padding: const EdgeInsets.all(6),
//               activeColor: Colors.white,
//               tabs: const [
//                 GButton(icon: Icons.home_rounded,
//                 //text: 'Home',
//                 ),
//                 GButton(icon: Icons.post_add_outlined,
//                 //text: 'Raise Fund',
//                 ),
//                 GButton(icon: Icons.person_rounded,
//                 //text: 'Profile',
//                 ),
//               ], 
//             ),
//           ),
//         ),
//       ));
//   }
// }

// class NavigationController extends GetxController{
//   final Rx<int> selectedIndex = 0.obs ;
//   final screens = [
//     const OrganisationFeed(),
//     Container(color: Colors.orange,),
//     const OrganisationProfilePage(),
//   ];
// }