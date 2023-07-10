import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/services/services.dart';
import '../../model/patient_model.dart';

abstract class SignUpForPatientController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  String? patienToken;

  signUp(BuildContext context);
  Future<void> addPatient({required PatientModel patientModel});
}

class SignUpForPatientControllerImp extends SignUpForPatientController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showSpinner = false;
  MyServices myServices = Get.find();

  @override
  signUp(BuildContext context) async {
    var formData = formState.currentState;
    showSpinner = true;
    if (formData!.validate()) {
      try {
        //showUpload(context: context);
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((value) {
          showSpinner = false;
          myServices.patientId = value.user!.uid;
          addPatient(
              patientModel: PatientModel(
            patientId: value.user!.uid,
            name: username.text,
            email: email.text,
            password: password.text,
            isAdmin: false,
            phone: phone.text,
            token: patienToken!,
            caregiverId: myServices.caregiverId!,
          ));
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Add Patient',
          desc: 'SUCCESS REGISTER PATIENT',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Get.offAllNamed(AppRoutes.homePage);
          },
        ).show();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'weak-password',
            desc: 'The password provided is too weak.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Get.back();
            },
          ).show();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: "email-already-in-use",
                  desc: "The account already exists for that email.",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    Get.back();
                  },
                  btnOkColor: Colors.blue)
              .show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Future<void> addPatient({required PatientModel patientModel}) async {
    myServices.collectionReferencePatient
        .doc(myServices.patientId)
        .set(
          patientModel.toMap(),
        )
        .then((value) {
      print('SUCCESS ADD Patient');
      myServices.collectionReferenceLocation.doc(myServices.patientId).set({
        'patientId': myServices.patientId,
        'lat': 31.4230493,
        'lng': 31.4230493
      });
    }).catchError((e) {
      print('FAIL ADD Patient');
    });
  }

  @override
  Future<void> onInit() async {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    patienToken = await myServices.messaging.getToken();

    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }
}
