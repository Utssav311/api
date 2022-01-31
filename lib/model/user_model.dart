class UserModel {
  int? id;
  String? username;
  String? email;
  String? password;
  String? profile;
  String? address;
  String? city;
  String? pincode;
  String? phone;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.profile,
    this.address,
    this.city,
    this.pincode,
    this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    username = map["username"];
    email = map["email"];
    password = map["password"];
    profile = map["profile"];
    address = map["address"];
    city = map["city"];
    pincode = map["pincode"];
    phone = map["phone"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "profile": profile,
        "address": address,
        "city": city,
        "pincode": pincode,
        "phone": phone,
      };
}
