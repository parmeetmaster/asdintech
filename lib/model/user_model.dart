/// case_id : "26816"
/// address_check_id : "26239"
/// applicant : "Rajwinder Kaur"
/// phoneno : "7888314280"
/// dob : "12 August 2000"
/// father_name : "Sarabjeet Singh"
/// address_detail : "531 Gandhi Nagar , Street No.2,  Sri Muktsar Sahib, Punj Muktsar Punjab - 152026 Complete address -House No-531, Gandhi Nagar , Street No.2,  Sri Muktsar Sahib,  Muktsar Punjab - 152026  Contact No-7888314280 / 7837798035 (Father)"
/// duration_of_stay : "Current Address  to Till Date"
/// vstatus : "0"
/// date_added : "2021-05-17"
/// portalno : "2"
/// pstatus : 0

class UserModel {
  String? caseId;
  String? addressCheckId;
  String? applicant;
  String? phoneno;
  String? dob;
  String? fatherName;
  String? addressDetail;
  String? durationOfStay;
  String? vstatus;
  String? dateAdded;
  String? portalno;
  int? pstatus;

  UserModel({
      this.caseId, 
      this.addressCheckId, 
      this.applicant, 
      this.phoneno, 
      this.dob, 
      this.fatherName, 
      this.addressDetail, 
      this.durationOfStay, 
      this.vstatus, 
      this.dateAdded, 
      this.portalno, 
      this.pstatus});

  UserModel.fromJson(dynamic json) {
    caseId = json["case_id"]??"";
    addressCheckId = json["address_check_id"]??"";
    applicant = json["applicant"]??"";
    phoneno = json["phoneno"]??"";
    dob = json["dob"]??"";
    fatherName = json["father_name"]??"";
    addressDetail = json["address_detail"]??"";
    durationOfStay = json["duration_of_stay"]??"";
    vstatus = json["vstatus"]??"";
    dateAdded = json["date_added"]??"";
    portalno = json["portalno"]??"";
    pstatus = json["pstatus"]??"";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["case_id"] = caseId;
    map["address_check_id"] = addressCheckId;
    map["applicant"] = applicant;
    map["phoneno"] = phoneno;
    map["dob"] = dob;
    map["father_name"] = fatherName;
    map["address_detail"] = addressDetail;
    map["duration_of_stay"] = durationOfStay;
    map["vstatus"] = vstatus;
    map["date_added"] = dateAdded;
    map["portalno"] = portalno;
    map["pstatus"] = pstatus;
    return map;
  }

}