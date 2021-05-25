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
    controller.text="p226816";
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill form by Id"),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.2),
            child: MultiLineTextInput(controller: controller,m_labelText: "Please Enter Id",),
          ),
          SizedBox(height: 20,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.2),
            child: GradientButton(text: "Submit Id",onpress: (){
              BgVerificationProvider().getinstance(context).setUpUserData(controller.text,context);
            },),
          )
        ],
      ),
    );
  }
}
