import 'package:caregiver_app/view/widget/custom_container_widget.dart';

import '../../controller/home_page_controller.dart';
import '../../model/common/navigation_drawer.dart' as custom;
import '../widget/custom_patient_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/other/custom_home_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp homePageControllerImp =
        Get.put(HomePageControllerImp());

    return Scaffold(
      appBar: AppBar(
        // title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Color(0xff096b6c),
        elevation: 0,
      ),
      drawer: const custom.NavigationDrawer(),
      body: Container(
        height: 600,
        child: GetBuilder<HomePageControllerImp>(
          builder: (homePageControllerImp) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                CustomHomeContainer(
                  widget: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/alz.png',
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Alzheimer Patients",
                            style: TextStyle(
                                fontFamily: 'MarckScript',
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        //color: Colors.purple.shade50,
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 18),
                          controller: homePageControllerImp.patientName,
                          cursorColor: Color(0xff08B5B6),
                          onChanged: (val) {
                            homePageControllerImp.name = val;
                            // homePageControllerImp.getUserFilter();
                            homePageControllerImp.getUserInfoFilter();
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 22, top: 16, bottom: 16),
                              hintText: 'search by patient name ...',
                              hintStyle:
                                  const TextStyle(color: Colors.blueGrey),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  homePageControllerImp.removeTextContains();
                                },
                                icon: Icon(
                                  homePageControllerImp.icon,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color(0xff08B5B6),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.cyan.shade100)),
                              fillColor: Colors.cyan.shade50,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Positioned(
                    top: 200,
                    child: StreamBuilder(
                        stream: homePageControllerImp.getUserFilter(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              // margin: EdgeInsets.only(right: 40),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.yellow,
                              child: (homePageControllerImp.isFound == true)
                                  ? ListView.builder(
                                      //itemCount: snapshot.data.docs.length,
                                      itemCount: homePageControllerImp
                                          .patientsListFilter.length,
                                      itemBuilder: (context, i) {
                                        return CustomPatientWidget(
                                          userName: homePageControllerImp
                                              .patientsListFilter[i].name,
                                          userId: homePageControllerImp
                                              .patientsListFilter[i].patientId,
                                          name: homePageControllerImp
                                                  .patientsListFilter[i]
                                                  .name[0] +
                                              homePageControllerImp
                                                  .patientsListFilter[i]
                                                  .name[1],
                                          // userName: snapshot.data.docs[i].data()["name"],
                                          // userId: snapshot.data.docs[i].data()["patientId"],
                                          // name: snapshot.data.docs[i].data()["name"][0] +
                                          //     snapshot.data.docs[i].data()["name"][1],
                                          onPressed: () {
                                            homePageControllerImp
                                                .goToPatientInfo(
                                                    patientId:
                                                        homePageControllerImp
                                                            .patientsListFilter[
                                                                i]
                                                            .patientId);
                                          },
                                        );
                                      })
                                  : const Center(
                                      child: Text('Patient is not found')),
                            );
                          } else if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blueGrey),
                            );
                          } else {
                            return const Text(
                              "no users",
                              style: TextStyle(fontSize: 24),
                            );
                          }
                        }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
