import 'package:flutter/material.dart';

class MultiLineTextInput extends StatelessWidget {
  String m_hintText;
  String? m_helperText;
  String m_labelText;
  IconData icon;
  TextStyle? hintstyle;
  TextEditingController? controller;
  bool? isenable;

  MultiLineTextInput(
      {this.m_hintText = "",
      this.m_helperText,
      this.m_labelText = "",
      this.controller,
        this.hintstyle,
        this.isenable,
      this.icon = Icons.pending_actions});

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: ThemeData().primaryColor,
        primaryColorDark: Colors.grey,
      ),
      child: new TextFormField(
        controller: controller,
        minLines: 1,
        enabled: isenable,
        //Normal textInputField will be displayed
        maxLines: 5,
        // when user presses enter it will adapt to it
        keyboardType: TextInputType.multiline,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            hintText: m_hintText,
            helperText: m_helperText,
            labelText: m_labelText,
            helperStyle: this.hintstyle,
            prefixIcon: Icon(
              icon,
            ),
            prefixText: ' ',
            contentPadding: EdgeInsets.only(right: 0,top: 18,bottom: 19,left: 0),
            suffixIcon: InkWell(
              onTap: () {
                controller!.text = "";
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.cancel,color: Colors.black54,),
              ),
            ),
            suffixStyle: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
