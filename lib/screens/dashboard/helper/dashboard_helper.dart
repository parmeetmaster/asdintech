import 'package:asdintech/screens/formIdScreen/form_id_screen.dart';
import 'package:flutter/material.dart';

class DashBoardHelper {
  static List<String> options = ["Fill Form"];
  static List<String> images = ["assets/svgs/contract.svg"];

  static perform_navigate(String name, BuildContext context) {
    if (name == options[0]) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormIdScreen()));
    }
  }
}
