import 'package:asdintech/screens/formIdScreen/form_id_screen.dart';
import 'package:flutter/material.dart';
import 'package:asdintech/utils/utils.dart';

class DashBoardHelper {
  static List<String> options = ["Fill Form"];
  static List<String> images = ["assets/svgs/contract.svg"];

  static perform_navigate(String name, BuildContext context) {
    if (name == options[0]) {
      FormIdScreen().pushDialog(context);
    }
  }



}
