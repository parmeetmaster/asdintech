import 'package:asdintech/globals/constants.dart';
import 'package:asdintech/providers/bg_verification_provider.dart';
import 'package:asdintech/widgets/button/gradient_button.dart';
import 'package:asdintech/widgets/drop_down/drop_down_text_field.dart';
import 'package:asdintech/widgets/drop_down/drop_down_text_field2.dart';
import 'package:asdintech/widgets/textbox/multiTextInput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormDataScreen extends StatefulWidget {
  const FormDataScreen({Key? key}) : super(key: key);

  @override
  _FormDataScreenState createState() => _FormDataScreenState();
}

class _FormDataScreenState extends State<FormDataScreen> {
  TextEditingController first_name = new TextEditingController();
  TextEditingController phone_number1 = new TextEditingController();
  TextEditingController phone_number2 = new TextEditingController();

  bool valuefirst = false;

  getTitle(String str) {
    return Text(
      str,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  var categories = ["Rented", "Owned", "Govt Accomodation", "PG Accomodation"];

  String _category = "";


  @override
  void didChangeDependencies() {
    ShowPermission();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BgVerificationProvider>(context);
    provider.context=context;
    //  provider.setUpUserData("p226816");

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<BgVerificationProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              getTitle("Personal Info"),
              SizedBox(
                height: 10,
              ),
              MultiLineTextInput(
                controller: provider.fullname,
                m_hintText: "Enter Details Here",
                m_helperText: "",
                m_labelText: "Full Name",
                icon: Icons.person_rounded,
              ),
              getTitle("Phone Number"),
              SizedBox(
                height: 15,
              ),
              MultiLineTextInput(
                controller: provider.phno1,
                m_hintText: "Enter Details Here",
                m_helperText: "*Required",
                m_labelText: "Phone Number",
                icon: Icons.phone,
                hintstyle: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 10,
              ),
              MultiLineTextInput(
                controller: provider.phno2,
                m_hintText: "Enter Details Here",
                m_helperText: "",
                m_labelText: "Phone Number 2",
                icon: Icons.phone,
              ),
              SizedBox(
                height: 10,
              ),
              // date time
              InkWell(
                onTap: () async {
                  DateTime date = DateTime.now();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1950, 05, 2, 00, 00, 00, 00, 00),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != date) {
                    provider.setDateOfBirth(picked);
                  }
                },
                child: AbsorbPointer(
                  child: MultiLineTextInput(
                    controller: provider.dob,
                    m_hintText: "Enter Details Here",
                    m_helperText: "",
                    m_labelText: "Date of Birth",
                    icon: Icons.calendar_today,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MultiLineTextInput(
                controller: provider.father_name,
                m_hintText: "Enter Details Here",
                m_helperText: "",
                m_labelText: "Father Name",
                icon: Icons.person_rounded,
              ),

              getTitle("Address"),
              SizedBox(
                height: 15,
              ),
              MultiLineTextInput(
                controller: value.permanent_address,
                m_hintText: "",
                m_helperText: "",
                m_labelText: "Permanent Address",
                icon: Icons.location_city,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    this.valuefirst = !valuefirst;
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.greenAccent,
                      value: this.valuefirst,
                      onChanged: (bool? value) {},
                    ),
                    Text(
                      "Click to Edit Duration",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              MultiLineTextInput(
                isenable: valuefirst,
                controller: value.address_duration,
                m_hintText: "Permanent Address",
                m_helperText: "*Required",
                m_labelText: "Address Duration",
                icon: Icons.location_city,
                hintstyle: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 10,
              ),

              getTitle("Address Type"),
              SizedBox(
                height: 10,
              ),
              // drop down here for selection
              DropDown(
                m_hintText: "Please Select permanent Residency",
                selected: null,
                m_labelText: " Address Type",
                items: categories,
                onselected: (string) {
                  value.address_type.text = string;
                },
              ),

              SizedBox(
                height: 20,
              ),
              getTitle("Reference Information - 1"),
              SizedBox(
                height: 10,
              ),
              _getReferenceGroup(
                  refname: value.ref_name_1,
                  refphno: value.ref_phno_1,
                  onselected: (str) {
                    value.ref_relationship_1.text = str;
                  }),
              SizedBox(
                height: 10,
              ),
              getTitle("Reference Information - 2"),
              SizedBox(
                height: 10,
              ),
              _getReferenceGroup(
                  refname: value.ref_name_2,
                  refphno: value.ref_phno_2,
                  onselected: (str) {
                    value.ref_relationship_2.text = str;
                  }),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Adhaar Card",
                  indicator: value.adhaar!, identity: idenenties.adhaar),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Pan Card",
                  indicator: value.pan!, identity: idenenties.pan),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Upload Selfie",
                  indicator: value.selfie!, identity: idenenties.selfie),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Home Plate Photograph",
                  indicator: value.home_plate!,
                  identity: idenenties.home_plate),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Building Photograph",
                  indicator: value.building!, identity: idenenties.building),
              SizedBox(
                height: 10,
              ),
              _getCameraBox("Authentic Signature",
                  indicator: value.signature!, identity: idenenties.signature),
            SizedBox(height: 50,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.25),

                child: GradientButton(onpress: (){
                  value.submitForm();
                },text: "Submit",),
              ),
              SizedBox(height: 50,),
            ],
          ),
        );
      }),
    );
  }

  _getReferenceGroup(
      {TextEditingController? refname,
      TextEditingController? refphno,
      String? phno,
      required Function onselected}) {
    return Container(
      child: Column(
        children: [
          MultiLineTextInput(
            controller: refname,
            m_labelText: "Reference Name",
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: MultiLineTextInput(
                  controller: refphno,
                  m_labelText: "Phone Number",
                ),
                flex: 5,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 2),
                    child: DropDown2(
                      onselected: onselected,
                      m_labelText: "Relationship",
                      items: [
                        "Friend",
                        "Father",
                        "Mother",
                        "Sister",
                        "Neighbourhood",
                        "Wife",
                        "Other"
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  _getCameraBox(String string, {bool indicator = true, dynamic identity}) {
    return InkWell(
      onTap: () {
        BgVerificationProvider()
            .getinstance(context)
            .showCameraSelectionDialog(context, identity: identity);
      },
      child: Container(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: Text(
                        string,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            indicator == true ? Colors.green[400] : Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                        child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 35,
                    )),
                  )),
              SizedBox(height: 40,),



            ],
          ),
        ),
      ),
    );
  }
}
