

class PatientModel{
  late String patientId;
  late String name;
  late String email;
  late String phone;
  late String password;
  late bool isAdmin;
  late String token;
  late String caregiverId;
  PatientModel
      (
      {
        required this.patientId,
        required this.name,
        required this.email,
        required this.password,
        required this.isAdmin,
        required this.phone,
        required this.token,
        required this.caregiverId

      }
      );


  factory PatientModel.fromMap(Map<String, dynamic> userData){
    return PatientModel(
        patientId: userData['patientId'],
        name: userData['name'],
        email: userData['email'],
        phone: userData['phone'],
      password: userData['password'],
      isAdmin: userData['isAdmin'],
      token: userData['token'],
      caregiverId: userData['caregiverId'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "patientId": patientId,
      "name": name,
      "email": email,
      "password":password,
      "isAdmin":isAdmin,
      "phone":phone,
      "token":token,
      'caregiverId':caregiverId
    };
  }
}