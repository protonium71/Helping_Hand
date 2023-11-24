import 'package:flutter/material.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:helping_hand/views/organisation/org_edit_profile.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:provider/provider.dart';

class OrganisationProfilePage extends StatefulWidget {
  const OrganisationProfilePage({super.key});

  @override
  State<OrganisationProfilePage> createState() => _OrganisationProfilePage();
}

class _OrganisationProfilePage extends State<OrganisationProfilePage> {
  String name = "";
  String upiID = "";
  String following = "";
  String profileURL = "";
   _changeState(dynamic value) async{
    OrganisationProvider organisationProvider = Provider.of(context, listen: false);
    await organisationProvider.refreshUser();
    Organisation organisation = organisationProvider.getOrganisation;
    Map<String, dynamic> organisationMap = organisation.getData();
    
    setState((){
      name = organisationMap['orgname']; 
      upiID = organisationMap['upiID'];
      following = organisationMap['following'].length.toString();
      profileURL = organisationMap['profileURL'];
      });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    Organisation organisation = Provider.of<OrganisationProvider>(context, listen: false).getOrganisation;
    Map<String, dynamic> organisationMap = organisation.getData();
    
    
    if(organisationMap['orgname'] == "") {
      name = "New Organisation";
    } else {
      name = organisationMap['orgname'];
    }
    if(organisationMap['upiID'] == "") {
      upiID = "no_upiID";
    } else {
      upiID = organisationMap['upiID'];
    }
    if(organisationMap['following'].length != 0) {
      following = organisationMap['following'].length.toString();
    } else {
      following = "0";
    }
    // print(organisationMap['following'].length);
    // print(following);
    
    profileURL = organisationMap['profileURL'];

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
                  child: Row(
                    children: [
                      Container( 
                        height: height*0.11,
                        width: height*0.11,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100),
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
                              const Icon(Icons.monetization_on_rounded, color: Color(0xFF7B6F72), size: 20,),
                              SizedBox(width: width*0.01,),
                              Text(
                                upiID,
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
                                child: Text(
                                  organisationMap['email'],
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
                MyButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrganisationEditProfilePage())).then(_changeState);
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
                          'Followers',
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
                                following,
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
                const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric( horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.corporate_fare_sharp),
                        SizedBox(width: 10,),
                        Text('About Us..', style: TextStyle(fontSize: 20, color: Color(0xff6379A5), fontWeight: FontWeight.bold)),
                    
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(organisationMap['bio']),
                  
                  ),              
              ],
            ),
          ),
        ),
      ),
    );
  }
}