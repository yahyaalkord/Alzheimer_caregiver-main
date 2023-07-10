import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late CollectionReference collectionReferenceCaregiver;
  late CollectionReference collectionReferencePatient;
  late CollectionReference collectionReferenceLocation;
  late CollectionReference collectionReferenceTask;
  late FirebaseMessaging messaging;

  String? patientId;
  String? caregiverId;
  String? taskId;
  String? patientFCMToken;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    collectionReferenceCaregiver =
        FirebaseFirestore.instance.collection("caregiver");
    collectionReferencePatient =
        FirebaseFirestore.instance.collection('patient');
    collectionReferenceLocation =
        FirebaseFirestore.instance.collection('location');
    collectionReferenceTask = FirebaseFirestore.instance.collection('task');
    messaging = FirebaseMessaging.instance;
    // Retrieve the FCM token for the patient
    messaging.getToken().then((token) {
      patientFCMToken = token;
    }).catchError((error) {
      print('Failed to get FCM token: $error');
    });
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
