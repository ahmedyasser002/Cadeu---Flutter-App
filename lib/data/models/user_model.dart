class User {
  final String countryCode;
  final String phoneNumber;
  final String password;
  final String? confirmPass;
  User(
      {required this.countryCode,
      required this.password,
      required this.phoneNumber,
      this.confirmPass});
   Map<String, dynamic> toJson() {
    

    return confirmPass !=null ? {
      "country_code": countryCode,
      "phone_number":phoneNumber,
      "password":password,

    }  : {
      "country_code": countryCode,
      "phone_number":phoneNumber,
      "password":password,
      "confirm_password":confirmPass
    };
  }
}
