import 'package:caregiver_app/view/screen/create_new_task.dart';
import 'package:caregiver_app/view/screen/edit_task.dart';
import 'package:caregiver_app/view/screen/home_page.dart';
import 'package:caregiver_app/view/screen/location_page.dart';
import 'package:caregiver_app/view/screen/patient_info.dart';
import 'package:caregiver_app/view/screen/patient_page.dart';
import 'package:caregiver_app/view/screen/send_notification.dart';
import 'package:caregiver_app/view/screen/sign_in.dart';
import 'package:caregiver_app/view/screen/sign_up.dart';
import 'package:caregiver_app/view/screen/sign_up_for_patient.dart';
import 'package:caregiver_app/view/screen/task_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'core/middleware/my_middle_ware.dart';
import 'core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  await initialServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: AppRoutes.signIn,
            page: () => const SignIn(),
            middlewares: [
              MyMiddleWare(),
            ]),
        GetPage(name: AppRoutes.signUp, page: () => const SignUp()),
        GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
        GetPage(
            name: AppRoutes.signUpFotPatent,
            page: () => const SignUpForPatient()),
        GetPage(name: AppRoutes.patientInfo, page: () => const PatientInfo()),
        GetPage(
            name: AppRoutes.sendNotification,
            page: () => const SendNotification()),
        GetPage(name: AppRoutes.patientPage, page: () => const PatientPage()),
        GetPage(name: AppRoutes.taskPage, page: () => const TaskPage()),
        GetPage(
            name: AppRoutes.createNewTask, page: () => const CreateNewTask()),
        GetPage(name: AppRoutes.locationPage, page: () => const LocationPage()),
        GetPage(name: AppRoutes.editTask, page: () => const EditTask()),
      ],
      initialRoute: AppRoutes.signIn,
    );
  }
}
