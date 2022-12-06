class AddAddressRequest {
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? pincode;
  String? locality;
  String? address;
  String? city;
  String? state;
  String? addressType;
  bool? isPrimary;

  AddAddressRequest(
      {this.firstName,
      this.lastName,
      this.mobileNo,
      this.pincode,
      this.locality,
      this.address,
      this.city,
      this.state,
      this.addressType,
      this.isPrimary});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['pincode'] = pincode;
    data['locality'] = locality;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['addressType'] = addressType;
    data['isPrimary'] = isPrimary;
    return data;
  }
}
