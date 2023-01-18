class StudentEventRequest {
  String? pid;
  String? firstName;
  String? lastName;
  String? gender;
  String? dob;
  ContactDetail? contactDetail;
  EducationDetail? educationDetail;
  PartentDetails? partentDetails;
  String? eventType;
  String? participantType;
  bool? status;

  StudentEventRequest(
      {pid,
        firstName,
        lastName,
        gender,
        dob,
        contactDetail,
        educationDetail,
        partentDetails,
        eventType,
        participantType,
        status});

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['dob'] = dob;
    if (contactDetail != null) {
      data['contactDetail'] = contactDetail!.toJson();
    }
    if (educationDetail != null) {
      data['educationDetail'] = educationDetail!.toJson();
    }
    if (partentDetails != null) {
      data['partentDetails'] = partentDetails!.toJson();
    }
    data['eventType'] = eventType;
    data['participantType'] = participantType;
    data['status'] = status;
    return data;
  }
}

class ContactDetail {
  String? emailId;
  String? mobileNo;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? country;

  ContactDetail(
      {emailId,
        mobileNo,
        address,
        city,
        state,
        pincode,
        country});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailId'] = emailId;
    data['mobileNo'] = mobileNo;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}

class EducationDetail {
  String? institutionName;
  String? institutionType;
  String? courseDetails;

  EducationDetail(
      {institutionName, institutionType, courseDetails});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['institutionName'] = institutionName;
    data['institutionType'] = institutionType;
    data['courseDetails'] = courseDetails;
    return data;
  }
}

class PartentDetails {
  bool? isGuardian;
  String? parentName;
  String? parentMobileNo;

  PartentDetails({isGuardian, parentName, parentMobileNo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGuardian'] = isGuardian;
    data['parentName'] = parentName;
    data['parentMobileNo'] = parentMobileNo;
    return data;
  }
}
