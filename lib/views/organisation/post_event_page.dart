import 'dart:io';

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:image_picker/image_picker.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

const List<String> months = <String>['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

class PostEventPage extends StatefulWidget {
  const PostEventPage({super.key});

  @override
  State<PostEventPage> createState() => _PostEventPageState();
}

class _PostEventPageState extends State<PostEventPage> {
  String selectedImagePath = '';
  dynamic dropdownValue;
  final eventname = TextEditingController();
  final cause = TextEditingController();
  final details = TextEditingController();
  final totalspots = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  String startDate = "", startTime = "", endDate = "", endTime = "";
  DateTime? searchDate = DateTime.now();
  TimeOfDay? searchTime = TimeOfDay.now();

  _showDatePicker(String date){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030)
    ).then((value){
      setState(() {
        searchDate = value;
        if(date == "start"){
          startDate = months[searchDate!.month].toString();
          startDate += " ${searchDate!.day.toString()}";
        }
        else if(date == "end"){
          endDate = months[searchDate!.month].toString();
          endDate += " ${searchDate!.day.toString()}";
        }
      });
    });
  }

  _showTimePicker(String time){
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
    ).then((value){
      setState(() {
        searchTime = value;
        if(time == "start"){
          startTime = searchTime!.hour.toString();
          startTime += " : ${searchTime!.minute.toString()} ${searchTime!.period.name}";
        }
        else if(time == "end"){
          endTime = searchTime!.hour.toString();
          endTime += " : ${searchTime!.minute.toString()} ${searchTime!.period.name}";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){},
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ), 
        centerTitle: true,
        title:  const Text(
          'Post Event',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //event name
                const Text(
                  "Name of Event",
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 102, 223),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: eventname,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "eg. Tech Event",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 177, 173, 173),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),   
                    ),  
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),
                    ),  
                  ),
                ),
                const SizedBox(height: 20,),
                //cause
                const Text(
                  "Cause",
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 102, 223),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton<String>(
                  itemHeight: 55,
                  value: dropdownValue,
                  hint: const Text(
                    "Select Cause",
                    style: TextStyle(
                      color: Color.fromARGB(255, 177, 173, 173),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 1,
                    color: const Color.fromARGB(255, 198, 194, 194),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Color(0xFF1D1517),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10,),
                //details
                const Text(
                  "Details",
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 102, 223),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: details,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "eg. Tech Event",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 177, 173, 173),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),   
                    ),  
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),
                    ),  
                  ),
                ),
                const SizedBox(height: 20,),
                //location
                const Text(
                  "Location",
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 102, 223),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20,),
                CountryStateCityPicker(
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
                const SizedBox(height: 30,),
                //start date
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start Date",
                            style: TextStyle(
                              color: Color.fromARGB(255, 78, 102, 223),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (startDate  == "") const Text(
                                '-/-/-',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 177, 173, 173),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ) else  Text(
                                startDate,
                                style: const TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){_showDatePicker("start");},
                                      child: const Icon(
                                        Icons.calendar_month_outlined, 
                                        color: Color.fromARGB(255, 78, 102, 223),
                                      )
                                    ), 
                                  ],
                                )
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Color.fromARGB(255, 198, 194, 194),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Set Time",
                            style: TextStyle(
                              color: Color.fromARGB(255, 78, 102, 223),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (startTime == "") const Text(
                                '--:--',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 177, 173, 173),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ) else Text(
                                startTime,
                                style: const TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){_showTimePicker("start");},
                                      child: const Icon(
                                        Icons.timer_outlined, 
                                        color: Color.fromARGB(255, 78, 102, 223),
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Color.fromARGB(255, 198, 194, 194),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                //end date
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "End Date",
                            style: TextStyle(
                              color: Color.fromARGB(255, 78, 102, 223),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (endDate  == "") const Text(
                                '-/-/-',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 177, 173, 173),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ) else  Text(
                                endDate,
                                style: const TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){_showDatePicker("end");},
                                      child: const Icon(
                                        Icons.calendar_month_outlined, 
                                        color: Color.fromARGB(255, 78, 102, 223),
                                      )
                                    ), 
                                  ],
                                )
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Color.fromARGB(255, 198, 194, 194),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Set Time",
                            style: TextStyle(
                              color: Color.fromARGB(255, 78, 102, 223),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (endTime == "") const Text(
                                '--:--',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 177, 173, 173),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ) else Text(
                                endTime,
                                style: const TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){_showTimePicker("end");},
                                      child: const Icon(
                                        Icons.timer_outlined, 
                                        color: Color.fromARGB(255, 78, 102, 223),
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Color.fromARGB(255, 198, 194, 194),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                //total spots
                const Text(
                  "Total Spots",
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 102, 223),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: totalspots,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: "eg. 30",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 177, 173, 173),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),   
                    ),  
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 198, 194, 194)),
                    ),  
                  ),
                ),
                //select image
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async{
                    selectImage();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    // margin: const EdgeInsets.symmetric(horizontal: 120),
                    width: 120,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4C95ADFE),
                          blurRadius: 22,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                      color: const Color(0xff6379A5), 
                      gradient: const LinearGradient(
                        begin: Alignment(-1.00, 0.08),
                        end: Alignment(1, -0.08),
                        colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text("Select image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                //show selected image
                if (selectedImagePath == "")
                const SizedBox(height: 0,) 
                else 
                Column(
                  children: [
                    Center(child: Image.file(File(selectedImagePath), height: 200, fit: BoxFit.fill,)),
                    const SizedBox(height: 20,),
                  ],
                ),
                //submit 
                MyButton(onTap: (){}, text: "Submit"),
              ],
            ),
          ),
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
                            if (selectedImagePath != '') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                            if (selectedImagePath != '') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

  //
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