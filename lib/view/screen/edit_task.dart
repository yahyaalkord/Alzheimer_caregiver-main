import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/edit_task_controller.dart';
import '../../core/function/valid_input.dart';
import '../widget/custom_text_form.dart';

class EditTask extends StatelessWidget {
  const EditTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditTaskControllerImp editTaskControllerImp =
        Get.put(EditTaskControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade500,
        elevation: 0,
      ),
      backgroundColor: Colors.purple.shade500,
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: editTaskControllerImp.getPatientTaskInfo(),
            builder: (context, AsyncSnapshot snapshot){
              if (snapshot.hasData) {
                return Form(
                  key: editTaskControllerImp.formState,
                  child: Column(
                    children: [
                      GetBuilder<EditTaskControllerImp>(
                        builder: (editTaskControllerImp) {
                          return CustomTextForm(
                            label: 'title',
                            initialValue: snapshot.data.docs[0].data()['title'],
                            onChanged: (val){
                              editTaskControllerImp.title=val;
                            },
                            valid: (val) {
                              return validInput(val!, 5, 30, 'title');
                            },

                          );
                        },
                      ),
                      GetBuilder<EditTaskControllerImp>(
                          builder: (editTaskControllerImp) {
                        return CustomTextForm(
                          label: 'description',
                          initialValue: snapshot.data.docs[0].data()['description'],
                          onChanged: (val){
                               editTaskControllerImp.description=val;
                          },
                          valid: (val) {
                            return validInput(val!, 10, 30, 'des');
                          },

                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 600,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Select Date \nand Time",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "October 2023",
                                  style: TextStyle(fontSize: 15, height: 1.3),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xfb3afaf),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12)),
                                child: ListView.builder(
                                    itemCount: editTaskControllerImp.day.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        height: 50,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: (i == 0)
                                              ? Colors.purple.shade100
                                              : const Color(0xfe8e8e8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: (i == 0)
                                              ? Border.all(
                                                  color: Colors.purple.shade400)
                                              : null,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "${i + 1}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              editTaskControllerImp.day[i],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                height: 53,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12)),
                                child: ListView.builder(
                                    itemCount: 24,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return GetBuilder<
                                              EditTaskControllerImp>(
                                          builder: (editTaskControllerImp) {
                                        return InkWell(
                                          onTap: () {
                                            editTaskControllerImp.selectHour(
                                                index: i);
                                          },
                                          child: Container(

                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: editTaskControllerImp
                                                    .hourColors[i],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: editTaskControllerImp
                                                        .borderHourColors[i])),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "${i + 1}:00",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 65,
                                decoration: BoxDecoration(
                                    color:const Color(0xfb3afaf),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12)),
                                child: ListView.builder(
                                    itemCount: editTaskControllerImp.day.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return GetBuilder<EditTaskControllerImp>(
                                          builder: (editTaskControllerImp){
                                        return InkWell(
                                          onTap: (){
                                            editTaskControllerImp.selectDuration(index: i);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color:editTaskControllerImp.durationColors[i],
                                              borderRadius: BorderRadius.circular(10),
                                              border:Border.all(color:editTaskControllerImp.borderDurationColors[i]),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${i + 1}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const Text(
                                                  "week",
                                                  style:  TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Repeat",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                height: 55,
                                child: ListView.builder(
                                  itemCount:
                                      editTaskControllerImp.repeats.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return GetBuilder<EditTaskControllerImp>(
                                        builder: (editTaskControllerImp) {
                                      return InkWell(
                                        onTap: () {
                                          editTaskControllerImp.selectRepeat(
                                              index: i);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: editTaskControllerImp
                                                .repeatColors[i],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: editTaskControllerImp
                                                    .borderRepeatColors[i]),
                                          ),
                                          child: Text(
                                            editTaskControllerImp.repeats[i],
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              InkWell(
                                onTap: () {
                                  editTaskControllerImp.editTaskButton(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.purple.shade500),
                                  child: const Text(
                                    "Save Edit",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if (!snapshot.hasData) {
                return  Center(child: CircularProgressIndicator(
                  color: Colors.purple.shade500,
                ));
              } else {
                return const Text("no task available");
              }
            }),
      ),
    );
  }
}
