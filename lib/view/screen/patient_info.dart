import 'package:caregiver_app/view/screen/patien_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/patient_info_controller.dart';
import '../widget/custom_container_widget.dart';
import '../widget/custom_row_widget.dart';
import '../widget/custom_select_widget.dart';
import '../widget/other/custom_home_container.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PatientInfoControllerImp patientInfoControllerImp =
        Get.put(PatientInfoControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Information"),
        backgroundColor: Color(0xff096b6c),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: patientInfoControllerImp.getPatientInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomHomeContainer(
                      widget: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(
                            //   height: 50,
                            // ),
                            Column(
                              children: [
                                CustomRowWidget(
                                  title:
                                      "${snapshot.data.docs[0].data()['name']}",
                                  icon: Icons.person,
                                  fontSize: 24,
                                  iconSize: 24,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomRowWidget(
                                  title:
                                      "${snapshot.data.docs[0].data()['email']}",
                                  icon: Icons.email,
                                  fontSize: 20,
                                  iconSize: 24,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomRowWidget(
                                  title:
                                      "${snapshot.data.docs[0].data()['phone']}",
                                  icon: Icons.phone,
                                  fontSize: 20,
                                  iconSize: 24,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Monitoring",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Container(
                      height: 600,
                      margin: const EdgeInsets.all(20),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                        ),
                        children: [
                          CustomSelectWidget(
                            color: Colors.yellow.shade400,
                            title: "Location",
                            icon: Icons.location_on_outlined,
                            onTap: () {
                              patientInfoControllerImp.goToLocationPage();
                            },
                          ),
                          CustomSelectWidget(
                            color: Colors.cyan.shade400,
                            title: "Reminder",
                            icon: Icons.notifications_none_rounded,
                            onTap: () {
                              patientInfoControllerImp.goToShowTaskPage();
                            },
                          ),
                          CustomSelectWidget(
                            color: Colors.cyan.shade400,
                            title: "Diary",
                            icon: Icons.note_add,
                            onTap: () {
                              // patientInfoControllerImp.goToShowTaskPage();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PatientDiaryScreen(
                                    id: snapshot.data.docs[0]
                                        .data()['patientId'],
                                  );
                                },
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Text("no user available");
            }
          }),
    );
  }
}
