class AddressModel {
  //int addressID;
  int userID;
  String fname;
  String phone;

  String hno;
  String road;
  String city;
  String state;
  String pincode;

  AddressModel({
    //required this.addressID,
    required this.userID,
    required this.fname,
    required this.phone,
    required this.hno,
    required this.road,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        //  addressID: json["addressID"],
        userID: json["userID"],
        fname: json["fname"],
        phone: json["phone"],
        hno: json["hno"],
        road: json["road"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toMap() => {
        // "addressID": addressID,
        "userID": userID,
        "fname": fname,
        "phone": phone,
        "hno": hno,
        "road": road,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
