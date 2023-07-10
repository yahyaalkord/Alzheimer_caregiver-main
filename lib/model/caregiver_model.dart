



class CaregiverModel{
  late String caregiverId;
  late String name;
  late String email;
  late String phone;
  late String password;
  late bool isAdmin;
  late String token;

  CaregiverModel
      (
      {
        required this.caregiverId,
        required this.name,
        required this.email,
        required this.password,
        required this.isAdmin,
        required this.phone,
        required this.token,

      }
      );



  Map<String,dynamic> toMap(){
    return {
      "caregiverId": caregiverId,
      "name": name,
      "email": email,
      "password":password,
      "isAdmin":isAdmin,
      "phone":phone,
      "token":token,
    };
  }

}