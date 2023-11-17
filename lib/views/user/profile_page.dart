import 'package:flutter/material.dart';
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/utilities/custom_profile_container.dart';
import 'package:helping_hand/utilities/my_button.dart';
import 'package:helping_hand/views/user/edit_profile_page.dart';
import 'package:helping_hand/views/user/signed_events_page.dart';
import 'package:provider/provider.dart';
import 'package:helping_hand/models/user.dart' as model;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    String name;
    String location;
    if(userMap['username'] == "")name = "New User";
    else name = userMap['username'];
    if(userMap['location'] == "")location = "no_location";
    else location = userMap['location'];

    return Scaffold(
      
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){},
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ), 
        centerTitle: true,
        title:  const Text(
          'Profile',
          style: TextStyle(
              color: Color(0xFF1D1517),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
          ),
        ),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 28),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.02),
            child: Column(
              children: [
                Container(
                  height: height*0.11,
                  // color: Colors.yellow,
                  child: Row(
                    children: [
                      Container( 
                        height: height*0.11,
                        width: height*0.11,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100) 
                          //more than 50% of width makes circle
                        ),
                      ),
                        SizedBox(width: width*0.03,),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            name,
                            style: const TextStyle(
                                color: Color(0xFF1D1517),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                            ),
                          ),
                            Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Color(0xFF7B6F72), size: 20,),
                              SizedBox(width: width*0.01,),
                              Text(
                                location,
                                style: const TextStyle(
                                    color: Color(0xFF7B6F72),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined, color: Color(0xFF7B6F72), size: 20,),
                              SizedBox(width: width*0.01,),
                              Container(
                                width: width*0.59,
                                // color: Colors.red,
                                child: Text(
                                  userMap['email'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Color(0xFF7B6F72),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.025,),
                MyButton(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));}, text: 'Edit Profile'),
                SizedBox(height: height*0.025,),
                Container(
                  width: width*0.9,
                  height: height*0.07,
                  decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 218, 234, 251),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                          BoxShadow(
                              color: Color(0x111D1617),
                              blurRadius: 40,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                          )
                      ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.04),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Volunteering Hours',
                          style: TextStyle(
                              color: Color(0xFF1D1517),
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                '0',
                                style: TextStyle(
                                    color: Color(0xFF7B6F72),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height*0.025,),
                CustomProfileContainer(text: 'Interests', type: 'interests', items: userMap['interests'],),
                SizedBox(height: height*0.025,),
                CustomProfileContainer(text: 'Skills', type: 'interests', items: userMap['skills'],),
                SizedBox(height: height*0.025,),
                CustomProfileContainer(text: 'Following', type: 'interests', items: userMap['following'],),
                SizedBox(height: height*0.025,),
                MyButton(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignedEventsPage()));
                }, text: 'Signed Events'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}