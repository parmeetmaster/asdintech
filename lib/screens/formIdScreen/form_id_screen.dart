import 'package:asdintech/providers/bg_verification_provider.dart';
import 'package:asdintech/widgets/button/gradient_button.dart';
import 'package:asdintech/widgets/textbox/multiTextInput.dart';
import 'package:flutter/material.dart';

class FormIdScreen extends StatefulWidget {
  const FormIdScreen({Key? key}) : super(key: key);

  @override
  _FormIdScreenState createState() => _FormIdScreenState();
}

class _FormIdScreenState extends State<FormIdScreen> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = "p226816";
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * .8,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  "Enter Reference Number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                MultiLineTextInput(
                  controller: controller,
                  m_labelText: "Enter Reference No",
                  m_helperText: "At end of link number like P153771",
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .2),
                  child: GradientButton(
                    text: "Submit",
                    onpress: () {
                      BgVerificationProvider()
                          .getinstance(context)
                          .setUpUserData(controller.text, context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
