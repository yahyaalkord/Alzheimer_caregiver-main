
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/services/services.dart';
import '../../model/caregiver_model.dart';

abstract class SignUpController extends GetxController{

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  String? token;
  signUp(BuildContext context);
  Future<void> addCaregiver({required CaregiverModel caregiverModel});

  goToSignInPage();
}

class SignUpControllerImp extends SignUpController{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  MyServices myServices = Get.find();

  @override
  goToSignInPage() {
    Get.toNamed(AppRoutes.signIn);
  }

  @override
  signUp(BuildContext context) async {

    var formData = formState.currentState;
    if(formData!.validate()) {
        try {

          //showUpload(context: context);
          final  credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          ).then((value) {

            addCaregiver(caregiverModel: CaregiverModel(
                caregiverId:  value.user!.uid,
                name: username.text,
                email: email.text,
                password: password.text,
                isAdmin: true,
                phone: phone.text,
                token: token!
            ));

          }
          ).catchError((e){

          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'ADD Caregiver',
            desc: 'SUCCESS REGISTER Caregiver',
            btnCancelOnPress: () {

            },
            btnOkOnPress: () {
              Get.back();
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
              btnCancelOnPress: () {

              },
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
                btnCancelOnPress: () {

                },
                btnOkOnPress: () {
                  Get.back();
                },
                btnOkColor: Colors.blue
            ).show();
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      }

    }

  @override
  Future<void> addCaregiver({required CaregiverModel caregiverModel}) async{
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection('caregiver').doc(caregiverModel.caregiverId).set(
      caregiverModel.toMap(),
    ).then((value) {
      print('SUCCESS ADD Caregiver');
    }).catchError((e){
      print('FAIL ADD Caregiver');
    });


  }
  @override
  void onInit() async {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();

    token = await myServices.messaging.getToken();


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