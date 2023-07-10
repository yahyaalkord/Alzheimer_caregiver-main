import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';

abstract class DrawerController extends GetxController {
  goToHomePage();
  goToRegisterPatientPage();
  goToSendNotificationPage();
  Future<QuerySnapshot> getPatientNameAndEmail();
  signOut();
}

class DrawerControllerImp extends DrawerController {
  String? caregiverId;
  MyServices myServices = Get.find();

  @override
  goToHomePage() {
    Get.toNamed(AppRoutes.homePage);
  }

  @override
  Future<QuerySnapshot> getPatientNameAndEmail() async {
    caregiverId = FirebaseAuth.instance.currentUser!.uid;
    print('caregiverId : $caregiverId');

    return await myServices.collectionReferenceCaregiver
        // .where('isAdmin', isEqualTo: true)
        .where("caregiverId", isEqualTo: myServices.caregiverId)
        .get();
  }

  @override
  signOut() {
    FirebaseAuth.instance.signOut();
    FirebaseFirestore.instance.clearPersistence();
    myServices.sharedPreferences.setBool('isLogin', false);
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  goToRegisterPatientPage() {
    Get.toNamed(AppRoutes.signUpFotPatent);
  }

  @override
  goToSendNotificationPage() {
    Get.toNamed(AppRoutes.sendNotification);
  }
}
