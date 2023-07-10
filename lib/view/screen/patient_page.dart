import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/paitent_page_controller.dart';
import '../../model/common/navigation_drawer.dart' as custom;
import '../widget/custom_container_widget.dart';
import '../widget/custom_patient_widget.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PatientPageControllerImp patientPageControllerImp =
        Get.put(PatientPageControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: const Color(0xff096b6c),
        elevation: 0,
      ),
      drawer: const custom.NavigationDrawer(),
      body: Container(
        height: 600,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const CustomContainerWidget(
              widget: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Alzheimer Patients",
                        style: TextStyle(
                            fontSize: 29,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 160,
              child: FutureBuilder(
                  future: patientPageControllerImp.getPatient(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 500,
                        width: 420,
                        // color: Colors.yellow,
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, i) {
                              return CustomPatientWidget(
                                userName: snapshot.data.docs[i].data()["name"],
                                userId:
                                    snapshot.data.docs[i].data()["patientId"],
                                name: snapshot.data.docs[i].data()["name"][0] +
                                    snapshot.data.docs[i].data()["name"][1],
                                onPressed: () {
                                  patientPageControllerImp.goToPatientInfo();
                                },
                              );
                            }),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Text(
                        "no users",
                        style: TextStyle(fontSize: 24),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
