import 'package:flutter/material.dart';

class DropDown2 extends StatefulWidget {
  String m_hintText;
  String? m_helperText;
  String m_labelText;
  IconData? icon;
  TextStyle? hintstyle;
  List<String> items;
  Function? onselected;
  String? selected;

  TextEditingController? controller;

  DropDown2(
      {Key? key,
      this.m_hintText = "",
      this.m_helperText,
      this.m_labelText = "",
      this.controller,
      this.hintstyle,
      this.selected,
      this.onselected,
      required this.items,
      this.icon})
      : super(key: key);

  @override
  _DropDown2State createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 0,

      //icon: Icon(Icons.location_city),
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.only(top: 9,left: 10,bottom: 24),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.teal)),
        hintText: widget.m_hintText,
        helperText: widget.m_helperText,
        labelText: widget.m_labelText,
        helperStyle: widget.hintstyle,
        prefixText: ' ',
      ),
      value: widget.selected,
      items: widget.items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() => widget.onselected!(value));
      },
    );
  }
}
