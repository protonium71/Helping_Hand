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

  String selectedImagePath = '';
  String imageURL = '';
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
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
            onTap: () {
              // print(context);
              // Navigator.pop(context);
              // print(context);
              // Navigator.pop(context1);
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        centerTitle: true,
        title: const Text(
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
            SizedBox(
              height: height * 0.02,
            ),
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
                        image: imageURL != ""
                            ? NetworkImage(imageURL)
                            : const AssetImage(
                                    "lib/assets/images/default_profile.jpg")
                                as ImageProvider,
                      ),
                    ),
                  ),
                  //EDIT PROFILE PIC BUTTON
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      onPressed: () async {
                        selectImage();
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
            SizedBox(
              height: height * 0.03,
            ),
            MyTextField(
                controller: controller,
                hintText: 'Enter name',
                obscureText: false),
            //location
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: CountryStateCityPicker(
                country: country,
                state: state,
                city: city,
                dialogColor: Colors.grey.shade200,
                textFieldDecoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    suffixIcon: const Icon(Icons.arrow_downward_rounded),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(3.0)))),
              ),
            ),
            //update button
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyButton(
                  onTap: () async {
                    bool flag = false;
                    if (controller.text != "") {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(id)
                          .update({"username": controller.text});
                      flag = true;
                    }
                    if (city.text != "") {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(id)
                          .update({"location": city.text});
                      flag = true;
                    }
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                    if (imageURL != "") {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(id)
                          .update({"profileURL": imageURL});
                      flag = true;
                    }
                    if (flag) {
                      showErrorMessage('profile updated..');
                    }
                  },
                  text: 'Update Profile'),
            ),
            //edit interests
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () async {
                  String res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InterestsPage()));
                  if (res == 'done') {
                    showErrorMessage('interest updated..');
                  }
                  // print(res);
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 234, 251),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //edit skills
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () async {
                  String res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SkillPage()));
                  if (res == 'done') {
                    showErrorMessage('skill updated..');
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 234, 251),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        )),
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

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            // ignore: avoid_print
                            print('Image_Path:- $selectedImagePath');
                            String uniqueName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDir =
                                referenceRoot.child('event_pics');
                            Reference imageToUpload =
                                referenceDir.child(uniqueName);
                            if (selectedImagePath != '') {
                              await imageToUpload
                                  .putFile(File(selectedImagePath));
                              String tempImageURL =
                                  await imageToUpload.getDownloadURL();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {
                                imageURL = tempImageURL;
                              });
                              // print(imageURL);
                            } else {
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'lib/assets/images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    const Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            // ignore: avoid_print
                            print('Image_Path:- $selectedImagePath');
                            String uniqueName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDir =
                                referenceRoot.child('event_pics');
                            Reference imageToUpload =
                                referenceDir.child(uniqueName);
                            if (selectedImagePath != '') {
                              await imageToUpload
                                  .putFile(File(selectedImagePath));
                              String tempImageURL =
                                  await imageToUpload.getDownloadURL();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {
                                imageURL = tempImageURL;
                              });
                              // print(imageURL);
                            } else {
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'lib/assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    const Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
