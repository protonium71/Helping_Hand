import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/widgets/custom_profile_container.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/views/user/edit_profile_page.dart';
import 'package:helping_hand/views/user/signed_events_page.dart';
import 'package:provider/provider.dart';
import 'package:helping_hand/models/user.dart' as model;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  String name = "";
  String location = "";
  List<dynamic> interests = [];
  List<dynamic> skills = [];
  String profileURL = "";
  int volunteeringHours = 0;

   _changeState(dynamic value) async{
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    model.User user = userProvider.getUser;
    Map<String, dynamic> userMap = user.getData();
    if(mounted) {
      setState((){
      name = userMap['username']; 
      location = userMap['location'];
      interests = userMap['interests'];
      skills = userMap['skills'];
      profileURL = userMap['profileURL'];
      print("3333"+profileURL);
      });
    }
    print(name);
  }
  

  _get_volunteredTime(List<dynamic> history)async{
      int total_hours = 0;
      int total_min = 0;
      for(int i = 0; i < history.length; i++){
        final e1 = await FirebaseFirestore.instance.collection('events').where('eventid', isEqualTo: history[i]).get();
        Timestamp t1 = e1.docs.first.data()['startTime'] ;
        Timestamp t2 = e1.docs.first.data()['endTime'] ;
        DateTime s_date = t1.toDate();
        DateTime e_date = t2.toDate();
        total_hours += e_date.hour - s_date.hour;
        total_min += e_date.minute - s_date.minute;
        
      }
      
      total_hours += ((total_min  + 59 )/ 60).toInt();
      if(this.mounted)
      setState(() {
          volunteeringHours = total_hours;
        });
      
    }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    
    
    if(userMap['username'] == "") {
      name = "New User";
    } else {
      name = userMap['username'];
    }
    if(userMap['location'] == "") {
      location = "no_location";
    } else {
      location = userMap['location'];
    }
    interests = userMap['interests'];
    skills = userMap['skills'];
    profileURL = userMap['profileURL'];
    _get_volunteredTime(userMap['upcomingEvents']) ;
    //print("0000"+volunteeringHours.toString());

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
                //user info
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
                          borderRadius: BorderRadius.circular(100),
                          //shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profileURL != "" ? NetworkImage(profileURL!) : const AssetImage("lib/assets/images/default_profile.jpg") as ImageProvider,), 
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
                //update button
                MyButton(
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage())).then(_changeState);
                  
                  }, 
                  text: 'Edit Profile'
                ),
                SizedBox(height: height*0.025,),
                //volunteering hours 
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
                              blurRadius: 22,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                          )
                      ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
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
                                volunteeringHours.toString(),
                                style: const TextStyle(
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
                //signed events button
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignedEventsPage()));
                  },
                  child: Container(
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
                                blurRadius: 22,
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
                            'Signed Events',
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
                                Icon(Icons.arrow_forward_ios, size: 20,),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.025,),
                //interests
                CustomProfileContainer(text: 'Interests', type: 'interests', items: userMap['interests'],),
                SizedBox(height: height*0.025,),
                //skills
                CustomProfileContainer(text: 'Skills', type: 'skills', items: userMap['skills'],),
                SizedBox(height: height*0.025,),
                //following
                CustomProfileContainer(text: 'Following', type: 'following', items: userMap['following'],),
                SizedBox(height: height*0.025,),               
              ],
            ),
          ),
        ),
      ),
    );
  }
}