import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/views/user/skill_page.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/my_textField.dart';
import 'package:helping_hand/views/user/interests_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:helping_hand/models/user.dart' as model;

class EditProfilePage extends StatefulWidget {
  //final BuildContext context1;

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final controller = TextEditingController();

  final country = TextEditingController();

  final state = TextEditingController();

  final city = TextEditingController();

  String? imageURL = "";

  @override
  Widget build(BuildContext context) {
    
 //Uint8List profile_pic;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    //imageURL = userMap['profileURL'];
    String id = userMap['uid'];
    
    // void selectImage()async{
    //   Uint8List img = await pickImage(ImageSource.gallery);
    //   setState(() {
    //     profile_pic = img;
    //   });
    // };

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            // print(context);
            // Navigator.pop(context);
            // print(context);
            // Navigator.pop(context1);
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ), 
        centerTitle: true,
        title:  const Text(
          'Edit Profile',
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
        child: Column(
          children: [
            //profile pic
            SizedBox(height: height*0.02,),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageURL != "" ? NetworkImage(imageURL!) : AssetImage("lib/assets/images/default_profile.jpg") as ImageProvider,),
                    ),
                  ),
                  //EDIT PROFILE PIC BUTTON
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      onPressed: () async{  
                        ImagePicker imagePicker = ImagePicker();
                        XFile? profile_pic = await imagePicker.pickImage(source: ImageSource.gallery);
                        if(profile_pic == null)return;
                        print('${profile_pic?.path}');
                        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDir = referenceRoot.child('profile_pics');
                        Reference imageToUpload = referenceDir.child(uniqueName);

                        try{
                          await imageToUpload.putFile(File(profile_pic!.path));
                          String tempImageURL = await imageToUpload.getDownloadURL();
                          //print("0000000"+tempImageURL);
                          setState(() {
                            imageURL = tempImageURL;
                          });
                          //print("0000000"+imageURL);
                        }
                        catch(error){

                        }
                      },
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: const Icon(Icons.edit, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            //name
            SizedBox(height: height*0.03,),
            MyTextField(controller: controller, hintText: 'Enter name', obscureText: false),
            //location
            SizedBox(height: height*0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.06),
              child: CountryStateCityPicker(
                country: country,
                state: state,
                city: city,
                dialogColor: Colors.grey.shade200,
                textFieldDecoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  suffixIcon: const Icon(Icons.arrow_downward_rounded), 
                  border:  const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(3.0)))),
              ),
            ),
            //update button
            SizedBox(height: height*0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyButton(onTap: () async {
                if(controller.text != "") {
                  await FirebaseFirestore.instance.collection("users").doc(id).update({"username":controller.text});
                }
                if(city.text != "") {
                  await FirebaseFirestore.instance.collection("users").doc(id).update({"location":city.text});
                }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                if(imageURL != "") {
                  await FirebaseFirestore.instance.collection("users").doc(id).update({"profileURL":imageURL});
                }
                

              }, text: 'Update Profile'),
            ),
            //edit interests
            SizedBox(height: height*0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InterestsPage()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 234, 251), 
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.04),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Edit Interests',
                          style: TextStyle(
                              color: Color(0xFF1D1517),
                              fontSize: 20,
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
                              Icon(Icons.arrow_forward_ios, size: 20,)
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //edit skills
            SizedBox(height: height*0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SkillPage()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 234, 251), 
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.04),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Edit Skills',
                          style: TextStyle(
                              color: Color(0xFF1D1517),
                              fontSize: 20,
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
                              Icon(Icons.arrow_forward_ios, size: 20,)
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}