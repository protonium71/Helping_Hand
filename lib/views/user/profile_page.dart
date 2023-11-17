import 'package:flutter/material.dart';
import 'package:helping_hand/widgets/custom_profile_container.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/views/user/edit_profile_page.dart';
import 'package:helping_hand/views/user/signed_events_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                          const Text(
                            'Loki Duck',
                            style: TextStyle(
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
                              const Text(
                                'Asgard',
                                style: TextStyle(
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
                                child: const Text(
                                  'seivastavaprashant112@gmail.com',
                                  maxLines: 2,
                                  style: TextStyle(
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
                                '30',
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
                const CustomProfileContainer(text: 'Interests', type: 'interests'),
                SizedBox(height: height*0.025,),
                const CustomProfileContainer(text: 'Skills', type: 'interests'),
                SizedBox(height: height*0.025,),
                const CustomProfileContainer(text: 'Following', type: 'interests'),
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