//import 'package:auth/components/work_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helping_hand/views/user/work_history.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //taking the list of string for the user interests
    List<String> interests = [
      "Interest3",
      "interest4",
      "inerest1",
      "interest2",
      "Interest3",
      "interest4",
      "inerest1",
      "interest2",
      "Interest3",
      "interest4"
    ];
    List<String> skills = [
      "Interest3",
      "interest4",
      "inerest1",
      "interest2",
      "Interest3",
      "interest4",
      "inerest1",
      "interest2",
      "Interest3",
      "interest4"
    ];
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
          onTap: (){},
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        ), 
          centerTitle: true,
          title:  Text(
            'Profile',
            style: TextStyle(
                color: Color(0xFF1D1517),
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
            ),
        ),

          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 28),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              SizedBox(
                height: 15,
              ),

              //USING STACK FOR THE IMAGE AND THE EDIT BUTTON
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
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            // image: NetworkImage("https://unsplash.com/photos/woman-with-dslr-camera-e616t35Vbeg")
                            image: NetworkImage(
                                "https://img.freepik.com/free-photo/abstract-design-with-colorful-patterns-nature-leaf-generated-by-ai_188544-15573.jpg?size=626&ext=jpg")),
                      ),
                    ),

                    //EDIT PROFILE PIC BUTTON
                    Positioned(
                      bottom: 0,
                      right: 0,
                      //   child: Container(
                      //   height: 40,
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     //shape: BoxShape.circle,
                      //     border: Border.all(
                      //       width: 4,
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //     ),
                      //     color:Colors.green,
                      //   ),

                      //   child:Icon(Icons.edit,color:Colors.white),
                      // )

                      child: MaterialButton(
                        onPressed: () {
                          // _showBottomSheet();
                        },
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Icon(Icons.edit, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),

              //ADDING SOME SPACE
              SizedBox(
                height: 10,
              ),

              //VOLUNTEER NAME
              // Text("Location: ", style: TextStyle(
              //     fontSize: 15,fontWeight: FontWeight.w400
              //   )),
              //   Text("Location: ", style: TextStyle(
              //     fontSize: 15,fontWeight: FontWeight.w400
              //   )),

              Text("Your Name",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              //ADDING SOME SPACE
              SizedBox(
                height: 8,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Location: ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  Text('Meerut, Uttar Pradesh',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16)),
                ],
              ),

              SizedBox(
                height: 5,
              ),

              // //VOLUNTEER EMAIL ADDRESS
              // Text("Email : yugam.2022ca116@mnnit.ac.in", style: TextStyle(
              //   fontSize: 15,fontWeight: FontWeight.w400
              // )),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  Text('yugam.2022ca116@mnnit.ac.in',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16)),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              //INTERESTS
              Text("Interests",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              //SPACE
              SizedBox(
                height: 10,
              ),

              //GRID VIEW FOR THE USER INTERESTS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 200,
                  child: GridView.custom(
                    // padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),

                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        String interest = interests[index];
                        double gridItemWidth = 100;
                        double gridItemHeight = 100;
                        return Container(
                          width: gridItemWidth,
                          height: gridItemHeight,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            interest,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          padding: EdgeInsets.all(20),
                        );
                      },
                      childCount: interests.length,
                    ),
                  ),
                ),
              ),

                     //SPACE
            SizedBox(
              height: 50,
            ),
            
      //GRID FOR THE SKILLSET
            Text("Skills", style: TextStyle(
              fontSize: 25,fontWeight: FontWeight.w500
            )),
            //SPACE
            SizedBox(
              height: 10,
            ),
      
            //GRID VIEW FOR THE USER SKILLS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 200,
                child: GridView.custom(
                  // padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10, 
                    ),
              
                    childrenDelegate: SliverChildBuilderDelegate((context, index){
                      String skill = skills[index];
                      double gridItemWidth = 100;
                      double gridItemHeight = 100;
                        return Container(
                          width: gridItemWidth,
                          height : gridItemHeight,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
              
                          ),
                        
                          alignment: Alignment.center,
                          child: Text(
                            skill,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                           padding: EdgeInsets.all(20),
                        );
                     
                    },
                    childCount: skills.length,
                    ),
                ),
              ),
            ),

            //ADDING SOME SPACE
            SizedBox(
              height: 40,
            ),
            Text("Your Work History", style: TextStyle(
              fontSize: 25,fontWeight: FontWeight.w500
            )),

            SizedBox(
              height: 20,
            ),

            //for the volunteer work history
            WorkHistory(),

              Container(
                height: 200,
              )
            ],
          ),
        ));
  }
}
