import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:asdintech/api/api.dart';
import 'package:asdintech/model/user_model.dart';
import 'package:asdintech/screens/form%20/form.dart';
import 'package:asdintech/screens/formIdScreen/form_id_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

enum idenenties { adhaar, pan, selfie, home_plate, building, signature }

class BgVerificationProvider extends ChangeNotifier {
  bool? adhaar = false;
  bool? pan = false;
  bool? selfie = false;
  bool? home_plate = false;
  bool? building = false;
  bool? signature = false;
  UserModel? model;
  List arr = [
    "Fill Form",
    "Web Based Form Fill",
  ];

  TextEditingController fullname = TextEditingController();
  TextEditingController phno1 = TextEditingController();
  TextEditingController phno2 = TextEditingController();

  TextEditingController dob = TextEditingController();
  TextEditingController father_name = TextEditingController();
  TextEditingController permanent_address = TextEditingController();

  TextEditingController edit_duration = TextEditingController();
  TextEditingController address_type = TextEditingController();

  TextEditingController ref_name_1 = TextEditingController();
  TextEditingController ref_phno_1 = TextEditingController();
  TextEditingController ref_relationship_1 = TextEditingController();

  TextEditingController ref_name_2 = TextEditingController();
  TextEditingController ref_phno_2 = TextEditingController();
  TextEditingController ref_relationship_2 = TextEditingController();

  DateTime? dob_date; //todo

  // TextEditingController permanent_address=TextEditingController();

  BgVerificationProvider getinstance(BuildContext context) {
    print(idenenties.adhaar.toString());
    return Provider.of<BgVerificationProvider>(context, listen: false);
  }

  // get data
  setUpUserData(String id, BuildContext context) async {
    model = await ApiBase().getUserData(id);
    this.fullname.text=model!.applicant!;
    this.phno1.text=model!.phoneno!;

    this.dob.text=model!.dob!;
    this.father_name.text=model!.fatherName!;

    this.permanent_address.text=model!.addressDetail!;
    this.edit_duration.text=model!.durationOfStay!;

Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context) => FormDataScreen()));


  }

  // permission

  showPermissiondialog(BuildContext context) async {
    // You can request multiple permissions at once.
    if (await Permission.camera.request() == false ||
        Permission.location.request().isGranted == false) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }

  // upload images
  // 1
  showCameraSelectionDialog(BuildContext context, {dynamic identity}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO_REVERSED,
      customHeader: SvgPicture.asset('assets/svgs/photo.svg'),
      body: Column(
        children: [
          Text(
            "Please Select Photo Type",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Center(
            child: Text(
              'Please Select Gallery to uplaod photos from local or select camera to take live',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkText: "Camera",
      btnOkIcon: Icons.camera_enhance_sharp,
      btnOkOnPress: () {
        pickImage(identity: identity, imagetype: ImageSource.camera);
      },
      btnCancelIcon: Icons.camera,
      btnCancelText: "Gallery",
      btnCancelOnPress: () {
        pickImage(identity: identity, imagetype: ImageSource.gallery);
      },
    )..show();
  }

  // 2

  pickImage({dynamic imagetype, dynamic identity}) async {
    PickedFile? file = await ImagePicker.platform.pickImage(source: imagetype);
    Uint8List imageBytes = await file!.readAsBytes();
    debugPrint(base64Encode(imageBytes));
    String base64String = base64Encode(imageBytes);
    uploadImage(base64String, identity);
  }

//3
  void uploadImage(String base64string, identity) async {
    if (idenenties.adhaar == identity) {
      adhaar = true;
      print("its adhaar");
      await ApiBase().uplaodImage("p124541", "adhaar_photo_tag", base64string);
    } else if (idenenties.pan == identity) {
      pan = true;
      print("its pan");
      await ApiBase().uplaodImage("p124541", "pancard_photo_tag", base64string);
    } else if (idenenties.home_plate == identity) {
      home_plate = true;
      print("its home_plate");
      await ApiBase()
          .uplaodImage("p124541", "homeplate_photo_tag", base64string);
    } else if (idenenties.building == identity) {
      building = true;
      print("its building");
      await ApiBase()
          .uplaodImage("p124541", "building_photo_tag", base64string);
    } else if (idenenties.signature == identity) {
      signature = true;
      print("its signature");
      await ApiBase().uplaodImage("p124541", "selfie_photo_tag", base64string);
    } else if (idenenties.selfie == identity) {
      selfie = true;
      print("its selfie");
      await ApiBase().uplaodImage("p124541", "selfie_photo_tag", base64string);
    }
    notifyListeners();
  }

  void setDateOfBirth(DateTime picked) {
    String mon_name = DateFormat.MMMM().format(picked);
    dob.text = "${picked.day} ${mon_name} ${picked.year}";
    notifyListeners();
  }
}
