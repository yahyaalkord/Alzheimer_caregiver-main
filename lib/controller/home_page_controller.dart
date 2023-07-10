import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';
import '../model/patient_model.dart';

abstract class HomePageController extends GetxController {
  Stream<QuerySnapshot> getPatient();
  Stream<QuerySnapshot> getUserInfo();
  goToPatientDetails({required String patientId});
  goToPatientInfo({required String patientId});
  Stream<QuerySnapshot<Object?>> getUserFilter();
}

class HomePageControllerImp extends HomePageController {
  MyServices myServices = Get.find();
  late TextEditingController patientName;
  String? name;
  IconData icon = Icons.search;
  List<String> names = [];
  List<String> ids = [];
  bool isFound = true;
  int j = 0;
  List<PatientModel> patientsList = [];
  List<PatientModel> patientsListFilter = [];

  // void test() async {
  //   var request = await myServices.collectionReferencePatient.get();
  //   for (var req in request.docs) {
  //     Map<String, dynamic> data = req.data() as Map<String, dynamic>;
  //     print('data = $data');
  //     names.add(data['name']);
  //     ids.add(data['patientId']);
  //   }
  //   // await myServices.collectionReferencePatient.get().then((value){
  //   //   value.docs.forEach((element) {
  //   //     Map<String,dynamic> data = element.data() as Map<String,dynamic>;
  //   //     for(int i =0 ;i<uid.length;i++){
  //   //       if(uid[i] == data['uid']){
  //   //         name.add(data['name']);
  //   //         image.add(data['image']);
  //   //         tokens.add(data['token']);
  //   //       }
  //
  //   update();
  // }
  //
  // test1(){
  //   List<String> filterNames =names.where((element){
  //        if(element.contains("a")){
  //            return true;
  //        }
  //        else{
  //          return false;
  //        }
  //   }).toList();
  // }

  // @override
  // Stream<QuerySnapshot> getPatient() {
  //   return myServices.collectionReferencePatient
  //       .where("isAdmin", isEqualTo: false)
  //       .where("caregiverId", isEqualTo: myServices.caregiverId)
  //       .snapshots();
  // }
  @override
  Stream<QuerySnapshot> getPatient() {
    return myServices.collectionReferencePatient
        .where('caregiverId', isEqualTo: myServices.caregiverId)
        .snapshots();
  }

  @override
  goToPatientDetails({required String patientId}) {
    // Get.toNamed(AppRoutes.userDetails);
  }
  @override
  Stream<QuerySnapshot<Object?>> getUserInfo() {
    return myServices.collectionReferencePatient
        .where("caregiverId", isEqualTo: myServices.caregiverId)
        .snapshots();
  }

  @override
  goToPatientInfo({required String patientId}) {
    myServices.patientId = patientId;
    print('======================$patientId');
    Get.toNamed(AppRoutes.patientInfo);
  }

  removeTextContains() {
    if (name != null) {
      patientsListFilter.clear();
      patientsListFilter.addAll(patientsList);
      patientName.clear();
      name = null;
      icon = Icons.search;
      update();
    } else {
      icon = Icons.search;
      update();
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getUserFilter() {
    Stream<QuerySnapshot<Object?>> snap;
    if (name != null) {
      snap = myServices.collectionReferencePatient
          .where('name', isEqualTo: name)
          .where('caregiverId', isEqualTo: myServices.caregiverId)
          .snapshots();
      icon = Icons.close;
      update();
    } else {
      snap = myServices.collectionReferencePatient
          .where('caregiverId', isEqualTo: myServices.caregiverId)
          .snapshots();
      icon = Icons.search;
      update();
    }
    return snap;
  }

  getUserInfoFilter() {
    if (name != null) {
      j = 0;
      patientsListFilter.clear();
      for (int i = 0; i < patientsList.length; i++) {
        if (patientsList[i].name.contains(name!)) {
          patientsListFilter.add(patientsList[i]);
          isFound = true;
          j++;
          update();
        } else {
          if (j == 0) {
            isFound = false;
            update();
          }
        }
      }
    } else {
      patientsListFilter.clear();
      patientsListFilter.addAll(patientsList);
      // isFound = true;
      update();
    }
  }

  // void getUserInformation() async {
  //   var request = await myServices.collectionReferencePatient.get();
  //   for (var req in request.docs) {
  //     Map<String, dynamic> data = req.data() as Map<String, dynamic>;
  //     patientsList.add(PatientModel.fromMap(data));
  //     patientsListFilter.add(PatientModel.fromMap(data));
  //   }
  // }
  // void getUserInformation() {
  //   myServices.collectionReferencePatient
  //       .where('isAdmin', isEqualTo: false)
  //       .where('caregiverId', isEqualTo: myServices.caregiverId)
  //       .get()
  //       .then((querySnapshot) {
  //     patientsList.clear();
  //     patientsListFilter.clear();
  //     querySnapshot.docs.forEach((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       patientsList.add(PatientModel.fromMap(data));
  //       patientsListFilter.add(PatientModel.fromMap(data));
  //     });
  //     update(); // Trigger UI update
  //   }).catchError((error) {
  //     // Handle error
  //     print('Error fetching patient data: $error');
  //   });
  // }
  void getUserInformation() {
    myServices.collectionReferencePatient
        .where('isAdmin', isEqualTo: false)
        .where('caregiverId', isEqualTo: myServices.caregiverId)
        .get()
        .then((querySnapshot) {
      patientsList.clear();
      patientsListFilter.clear();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        patientsList.add(PatientModel.fromMap(data));
        patientsListFilter.add(PatientModel.fromMap(data));
      });
      update(); // Trigger UI update
    }).catchError((error) {
      // Handle error
      print('Error fetching patient data: $error');
    });
  }

  @override
  void onInit() {
    FirebaseFirestore.instance.clearPersistence();
    patientsList.clear();
    patientsListFilter.clear();

    patientName = TextEditingController();

    myServices.caregiverId =
        myServices.sharedPreferences.get('caregiverId').toString();
    getUserInformation();

    super.onInit();
  }

  @override
  void dispose() {
    patientName.dispose();
    super.dispose();
  }
}
