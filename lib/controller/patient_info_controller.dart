
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../core/constant/routes.dart';
import '../core/services/services.dart';

abstract class PatientInfoController extends GetxController{
  Future<QuerySnapshot>  getPatientNameAndEmail();
  Future<QuerySnapshot<Object?>> getPatientInfo();
  sendNotification ({
    required String title,
    required String body,
    required String id
  });

  goToShowTaskPage();
  goToLocationPage();
}

class  PatientInfoControllerImp extends PatientInfoController{
  MyServices myServices = Get.find();
  String? caregiverId;
  final String serverToken = 'AAAAw9cbzS8:APA91bGKdJtqwuhbJvSZuCOCwIw6R6mAAHayKlqHuh8znSo0q-wrt778jIyAp5BccbgLUF8xn3b798zdz3xEHggusVFx0Lxcaoe0lVthax8QtjVioFmgyi7mqkXa_caPH8IxNrwxkSE8';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  Future<QuerySnapshot<Object?>> getPatientInfo() async{
    return await myServices.collectionReferencePatient.where(
        "patientId",isEqualTo: myServices.patientId
    ).get();
  }

  @override
  Future<QuerySnapshot>  getPatientNameAndEmail() async {
    caregiverId = FirebaseAuth.instance.currentUser!.uid;
    print('caregiverId : $caregiverId');

    return await myServices.collectionReferenceCaregiver.where('isAdmin',isEqualTo: true).get();

  }

  @override
  sendNotification ({
    required String title,
    required String body,
    required String id
  }) async{
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id,
            'status': 'done'
          },
          'to': "dvuoKYSWTFeQ0m-SdXJ5Xf:APA91bFJ1TKZRDG4ubiLQERgcDEpYyG2wSuk"
              "dM9KwMudXGfcwuJOQQjVyzeY5u8DAgvMAIm0kjPzN07dXy98KcddC2Uk-B6aEWOPTmW"
              "5iSXhrY-ihID6mGkqzJ79nTkgLg0Xl7uBRaeG",
        },
      ),
    );
  }

  @override
  goToShowTaskPage() {
    Get.toNamed(AppRoutes.taskPage);
  }

  @override
  goToLocationPage() {
    Get.toNamed(AppRoutes.locationPage);
  }
}