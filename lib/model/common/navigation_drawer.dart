import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/drawer_controller.dart';
import '../../core/constant/routes.dart';
import '../../view/widget/drawer/build_drawer_header.dart';
import '../../view/widget/drawer/build_drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DrawerControllerImp drawerControllerImp = Get.put(DrawerControllerImp());
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        child: ListView(
          children: [
            // FutureBuilder(
            //     future: drawerControllerImp.getPatientNameAndEmail(),
            //     builder: (context, AsyncSnapshot snapshot) {
            //       if (snapshot.hasData) {
            //         return BuildDrawerHeader(
            //           accountName: '${snapshot.data.docs[0].data()['name']}',
            //           name:
            //               '${snapshot.data.docs[0].data()['name'][0] + snapshot.data.docs[0].data()['name'][1]}',
            //         );
            //       } else if (!snapshot.hasData) {
            //         return const Center(child: CircularProgressIndicator());
            //       } else {
            //         return const Text("no user available");
            //       }
            //     }),
            FutureBuilder(
              future: drawerControllerImp.getPatientNameAndEmail(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text("Error occurred");
                } else if (snapshot.hasData) {
                  var data = snapshot.data;
                  return BuildDrawerHeader(
                    accountName: '${data.docs[0].data()['name']}',
                    name:
                        '${data.docs[0].data()['name'][0] + data.docs[0].data()['name'][1]}',
                  );
                } else {
                  return const Text("No data available");
                }
              },
            ),
            BuildDrawerItem(
              text: "Home Page",
              onTap: () {
                drawerControllerImp.goToHomePage();
              },
              icon: Icons.home,
              textIconColor: Get.currentRoute == AppRoutes.homePage
                  ? Color(0xff08B5B6)
                  : Colors.grey,
              titleColor: Get.currentRoute == " " ? Colors.white : Colors.white,
            ),
            BuildDrawerItem(
              text: "Register For Patient",
              onTap: () {
                drawerControllerImp.goToRegisterPatientPage();
              },
              icon: Icons.app_registration_outlined,
              textIconColor: Get.currentRoute == AppRoutes.signUpFotPatent
                  ? Color(0xff08B5B6)
                  : Colors.grey,
              titleColor: Get.currentRoute == " " ? Colors.white : Colors.white,
            ),
            BuildDrawerItem(
              text: "Send Notification",
              onTap: () {
                drawerControllerImp.goToSendNotificationPage();
              },
              icon: Icons.notifications,
              textIconColor: Get.currentRoute == AppRoutes.sendNotification
                  ? Color(0xff08B5B6)
                  : Colors.grey,
              titleColor: Get.currentRoute == " " ? Colors.white : Colors.white,
            ),
            BuildDrawerItem(
              text: "Logout",
              onTap: () {
                drawerControllerImp.signOut();
              },
              icon: Icons.logout,
              textIconColor: Get.currentRoute == AppRoutes.patientInfo
                  ? Color(0xff08B5B6)
                  : Colors.grey,
              titleColor: Get.currentRoute == " " ? Colors.white : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
