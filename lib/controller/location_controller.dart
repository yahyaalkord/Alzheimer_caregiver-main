
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';

abstract class LocationController extends GetxController{

  Stream<QuerySnapshot<Object?>> getUserLocation();
}

class LocationControllerImp extends LocationController{

  MyServices myServices = Get.find();
  @override
  Stream<QuerySnapshot<Object?>> getUserLocation() {
    return  myServices.collectionReferenceLocation.where(
        "patientId",isEqualTo:myServices.patientId
    ).snapshots();
  }
}