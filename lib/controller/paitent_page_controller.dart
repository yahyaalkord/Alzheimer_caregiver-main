

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../core/constant/routes.dart';
import '../core/services/services.dart';


abstract class PatientPageController extends GetxController{

  Future<QuerySnapshot> getPatient();
  Future<QuerySnapshot> getUserInfo();
  goToPatientDetails({required String patientId});
  String? patientId;
  goToPatientInfo();
}

class PatientPageControllerImp extends PatientPageController{

  MyServices myServices = Get.find();

  @override
  Future<QuerySnapshot> getPatient() async{


    return await myServices.collectionReferencePatient.where(
        "isAdmin",isEqualTo: false
    ).get();
  }

  @override
  goToPatientDetails({required String patientId}) {
    // uId = userId;
    // Get.toNamed(AppRoutes.userDetails);
  }

  @override
  Future<QuerySnapshot<Object?>> getUserInfo() async{
    return await myServices.collectionReferencePatient.where(
        "patientId",isEqualTo: patientId
    ).get();
  }

  @override
  goToPatientInfo() {
    Get.toNamed(AppRoutes.patientInfo);
  }

}