
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/services/services.dart';
abstract class SignInController extends GetxController{
  goToSignUpPage();
  late TextEditingController email;
  late TextEditingController password;
  signIn(BuildContext context);


}

class SignInControllerImp extends SignInController{
  MyServices myServices = Get.find();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  goToSignUpPage() {
    Get.toNamed(AppRoutes.signUp);
  }

  @override
  signIn(BuildContext context) async {
    var formData = formState.currentState;
    if(formData!.validate()) {
      try {


         showSpinner = true;
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        ).then((value){
           myServices.sharedPreferences.setBool('isLogin', true);
           print('====================');
           print('sharedPreferences  ${myServices.sharedPreferences.getBool('isLogin')}');
           print('====================');
           showSpinner = false;
           myServices.sharedPreferences.setString('caregiverId', value.user!.uid);
        });

        Get.offAllNamed(AppRoutes.homePage);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'user-not-found',
            desc: 'No user found for that email.',
            btnCancelOnPress: () {

            },
            btnOkOnPress: () {
              Get.back();
            },
          ).show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'wrong-password',
            desc: 'Wrong password provided for that user.',
            btnCancelOnPress: () {

            },
            btnOkOnPress: () {
              Get.back();
            },
          ).show();
          print('Wrong password provided for that user.');
        }
      }

    }
    else{

    }

  }
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }



}