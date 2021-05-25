import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardCard extends StatelessWidget {
  String title;
  String image;

  DashBoardCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
          elevation: 5,
          shadowColor: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(
                height:50,
                width: 50,
                child: SvgPicture.asset(image)),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(title,  style: GoogleFonts.openSans(fontSize: 15),textAlign: TextAlign.center,),)
            ],
          )),
    );
  }
}
