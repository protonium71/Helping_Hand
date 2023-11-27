import 'package:flutter/material.dart';
import 'package:helping_hand/widgets/following_card.dart';
import 'package:helping_hand/widgets/interest_card.dart';
import 'package:helping_hand/widgets/utils.dart';

class CustomProfileContainer extends StatelessWidget {
  final String text;
  final String type;
  final List items;

  const CustomProfileContainer(
      {super.key, required this.text, required this.type, required this.items});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.9,
      height: items.isEmpty
          ? height * 0.07
          : type == "following"
              ? height * 0.23
              : height * 0.2,
      decoration: ShapeDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10,),0.230 - 0.191
            Container(
              // color: Colors.amber,
              height: height*0.04,
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            items.isEmpty
                ? const SizedBox(
                    height: 0,
                  )
                : Container(
                  // color: Colors.blue,
                    height: height * 0.01,
                  ),
            items.isEmpty
                ? const SizedBox(
                    height: 0,
                  )
                : Container(
                    height: type == "following" ? height * 0.16 : height * 0.13,
                    // color: Colors.black,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (type == 'interests') {
                            return Padding(
                              padding: EdgeInsets.all(height*0.01),
                              child: Container(
                                height: height * 0.11,
                                width: width * 0.237,
                                child: InterestCard(
                                  text: items[index]!,
                                  icon: i_string_icon[items[index]]!,
                                  size: 11,
                                  list: const [],
                                ),
                              ),
                            );
                          } else if (type == 'skills') {
                            return Padding(
                              padding: EdgeInsets.all(height*0.01),
                              child: Container(
                                height: height * 0.11,
                                width: width * 0.237,
                                child: InterestCard(
                                    text: items[index],
                                    icon: s_string_icon[items[index]]!,
                                    size: 11,
                                    list: const []),
                              ),
                            );
                          } else {
                            return Padding(
                                padding: EdgeInsets.all(height * 0.01),
                                child: FollowingCard(
                                  text: items[index]!,
                                  size: 10,
                                ));
                          }
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
