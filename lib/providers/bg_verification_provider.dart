import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:asdintech/api/api.dart';
import 'package:asdintech/model/user_model.dart';
import 'package:asdintech/screens/errors/11_broken_link.dart';
import 'package:asdintech/screens/form%20/form.dart';

import 'package:asdintech/utils/m_progress_indicator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:asdintech/utils/utils.dart';

enum idenenties { adhaar, pan, selfie, home_plate, building, signature }

class BgVerificationProvider extends ChangeNotifier {
  BuildContext? context; //todo
  bool? adhaar = false;
  String? adhaarloc = "";

  //
  bool? pan = false;
  String? panloc = "";

  //
  bool? selfie = false;
  String? selfieloc = "";

  //
  bool? home_plate = false;
  String? home_plate_loc = "";

  //
  bool? building = false;
  String? building_loc = "";

  //
  bool? signature = false;
  String? signature_loc = "";

  //
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

  TextEditingController address_duration = TextEditingController();
  TextEditingController address_type = TextEditingController();

  TextEditingController ref_name_1 = TextEditingController();
  TextEditingController ref_phno_1 = TextEditingController();
  TextEditingController ref_relationship_1 = TextEditingController();

  TextEditingController ref_name_2 = TextEditingController();
  TextEditingController ref_phno_2 = TextEditingController();
  TextEditingController ref_relationship_2 = TextEditingController();

  DateTime? dob_date;


  // TextEditingController permanent_address=TextEditingController();

  BgVerificationProvider getinstance(BuildContext context) {
    print(idenenties.adhaar.toString());
    return Provider.of<BgVerificationProvider>(context, listen: false);
  }

  // get data
  setUpUserData(String id, BuildContext context) async {
    MProgressIndicator.show(context);

    try {
      model = await ApiBase().getUserData(id);
    } on DioError catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BrokenLinkScreen()));
      MProgressIndicator.hide();
    } catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BrokenLinkScreen()));
      print("data error");
      MProgressIndicator.hide();
    }

    MProgressIndicator.hide();
    this.fullname.text = model!.applicant!;
    this.phno1.text = model!.phoneno!;

    this.dob.text = model!.dob!;

    //address
    this.permanent_address.text = model!.addressDetail!;
    this.address_duration.text = model!.durationOfStay!;

    // date of bith

    if (model!.dob != null) {
      DateFormat format = new DateFormat("dd MMMM  yyyy");
      //  dob_date = format.parse(model!.dob!);
    }

    //father name
    this.father_name.text = model!.fatherName!;

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => FormDataScreen()));
  }

  // permission

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
    PickedFile? file = await ImagePicker.platform
        .pickImage(source: imagetype, imageQuality: 50);
    Uint8List imageBytes = await file!.readAsBytes();
    debugPrint(base64Encode(imageBytes));
    String base64String = base64Encode(imageBytes);
    uploadImage(base64String, identity);
  }

//3
  void uploadImage(String base64string, identity) async {
    String userid = "P${model!.portalno!}${model!.caseId!}";

    MProgressIndicator.show(context!);
    LocationData? locationData;
    try {
      locationData = await CustomLocation().getLocation();
      if(locationData==null){
        "Location Error please wait or check at Settings of App".showSnackbar(context!);
      }
    } catch (e) {}

    if (idenenties.adhaar == identity) {
      adhaar = true;
      print("its adhaar");
      await ApiBase()
          .uplaodImage("${userid}", "adhaar_photo_tag", base64string);
      this.adhaarloc=getLatLng(locationData, );
    } else if (idenenties.pan == identity) {
      pan = true;
      print("its pan");
      this.panloc= getLatLng(locationData,);
      await ApiBase()
          .uplaodImage("${userid}", "pancard_photo_tag", base64string);
    } else if (idenenties.home_plate == identity) {
      home_plate = true;
      this.home_plate_loc=  getLatLng(locationData,);
      print("its home_plate");
      await ApiBase()
          .uplaodImage("${userid}", "homeplate_photo_tag", base64string);
    } else if (idenenties.building == identity) {
      building = true;
      print("its building");
      this.building_loc=   getLatLng(locationData, );
      await ApiBase()
          .uplaodImage("${userid}", "building_photo_tag", base64string);
    } else if (idenenties.signature == identity) {
      signature = true;
      this.signature_loc=getLatLng(locationData, );
      print("its signature");
      await ApiBase()
          .uplaodImage("${userid}", "selfie_photo_tag", base64string);
    } else if (idenenties.selfie == identity) {
      selfie = true;
      this.selfieloc=    getLatLng(locationData,);
      print("its selfie");
      await ApiBase()
          .uplaodImage("${userid}", "selfie_photo_tag", base64string);
    }
    MProgressIndicator.hide();
    notifyListeners();
  }

  void setDateOfBirth(DateTime picked) {
    String mon_name = DateFormat.MMMM().format(picked);
    dob.text = "${picked.day} ${mon_name} ${picked.year}";
    notifyListeners();
  }

  validate() {


    if (this.fullname.text.isEmpty) {
      "Full Name in can'nt be Empty".showSnackbar(context!);
      return false;
    } else if (this.phno1.text.isEmpty) {
      "Phone Number 1  can'nt be Empty".showSnackbar(context!);
      return false;
    } else if (this.dob.text.isEmpty) {
      "Date of birth have error".showSnackbar(context!);
      return false;
    }
  }

  void submitForm() async {
    validate();

    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    print("submit");
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://asdintech.com/webapi/InsertSql/savedata'));
    request.fields.addAll({
      'case_id': '${model!.caseId!}',
      'address_check_id': '${model!.addressCheckId!}',
      'applicant': '${fullname.text}',
      'phoneno':
          '[{"phone_number":"${phno1.text}"},{"phone_number":"${phno2.text}"}]',
      'dob': '${dob.text}',
      'father_name': '"${father_name.text}"',
      'address_detail':
          '[{"address_data":"${this.permanent_address.text}","duration_data":"${this.address_duration.text}"}]',
      'vstatus': '"1"',
      'date_added': '"${date}"',
      'reference_detail':
          '[{"reference_name":"${ref_name_1.text}","reference_phno":"${ref_phno_1.text}","reference_relation_Type":"${ref_relationship_1.text}"},{"reference_name":"${ref_name_2.text}","reference_phno":"${ref_phno_2.text}","reference_relation_Type":"${ref_relationship_2.text}"}]',
      'id_proof_links': 'NA',
      'id_proof_geolocaton':
          '{"signatureGeotag":"${signature_loc}","selfieGeotag":"${selfieloc}","homePlateGeotag":"${home_plate_loc}","adhaarGeotag":"${adhaarloc}","buildingGeotag":"${building_loc}","Submit_Location":"${signature_loc}","panGeotag":"${panloc}"}',
      'portalno': '${model!.portalno!}',
      'other': '["${this.address_type.text}"]'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  String? getLatLng(LocationData? locationData) {
    String? key;
    if (locationData != null)
      key = "${locationData.latitude} ${locationData.longitude}";
    else
      key = "0.0 0.0";
    return key;
  }
}
