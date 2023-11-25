import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/my_textField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OrganisationEditProfilePage extends StatefulWidget {
  //final BuildContext context1;

  const OrganisationEditProfilePage({super.key});

  @override
  State<OrganisationEditProfilePage> createState() => _OrganisationEditProfilePage();
}

class _OrganisationEditProfilePage extends State<OrganisationEditProfilePage> {
  final controller = TextEditingController();

  final upi_controller = TextEditingController();

  final bio_controller = TextEditingController();

  //final upiID_controller = TextEditingController();

  String? imageURL = "";
  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(message),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    
 //Uint8List profile_pic;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Organisation organisation = Provider.of<OrganisationProvider>(context, listen: false).getOrganisation;
    Map<String, dynamic> organisationMap = organisation.getData();
    // //imageURL = userMap['profileURL'];
    String id = organisationMap['uid'];
    
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
                        XFile? profilePic = await imagePicker.pickImage(source: ImageSource.gallery);
                        if(profilePic == null)return;
                        print('${profilePic?.path}');
                        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDir = referenceRoot.child('profile_pics');
                        Reference imageToUpload = referenceDir.child(uniqueName);

                        try{
                          await imageToUpload.putFile(File(profilePic!.path));
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
            MyTextField(controller: upi_controller, hintText: 'Enter upi ID', obscureText: false),
            SizedBox(height: height*0.02,),
            
            //update button
            //SizedBox(height: height*0.03,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: TextField(
                  minLines: 2,
                  maxLines: 20,
                  controller: bio_controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    //prefixIcon: icon,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter bio..',
                  
                ),
              ),
            ),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyButton(onTap: () async {
                bool flag = false;
                if(controller.text != "") {
                  await FirebaseFirestore.instance.collection("organisations").doc(id).update({"orgname":controller.text});
                  flag = true;
                }
                if(upi_controller.text != "") {
                  await FirebaseFirestore.instance.collection("organisations").doc(id).update({"upiID":upi_controller.text});
                  flag = true;
                }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                if(imageURL != "") {
                  await FirebaseFirestore.instance.collection("organisations").doc(id).update({"profileURL":imageURL});
                  flag = true;
                }
                if(bio_controller.text != "") {
                  await FirebaseFirestore.instance.collection("organisations").doc(id).update({"bio":bio_controller.text});
                  flag = true;
                }
                if(flag)
                 showErrorMessage('profile updated..');
                
              }, text: 'Update Profile'),
            ),
            //edit interests
            SizedBox(height: height*0.03,),
            //edit skills
            //SizedBox(height: height*0.03,),
            ],
        ),
      ),
    );
  }
}