import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/create_task_controller.dart';
import '../../core/function/valid_input.dart';
import '../widget/custom_text_form.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateTaskControllerImp createTaskControllerImp =
        Get.put(CreateTaskControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Task"),
        centerTitle: true,
        backgroundColor: Color(0xff096b6c),
        elevation: 0,
      ),
      backgroundColor: Color(0xff096b6c),
      body: SingleChildScrollView(
        child: Form(
          key: createTaskControllerImp.formState,
          child: Column(
            children: [
              GetBuilder<CreateTaskControllerImp>(
                builder: (createTaskControllerImp) {
                  return CustomTextForm(
                    label: 'title',
                    valid: (val) {
                      return validInput(val!, 5, 30, 'title');
                    },
                    controller: createTaskControllerImp.title,
                  );
                },
              ),
              GetBuilder<CreateTaskControllerImp>(
                  builder: (createTaskControllerImp) {
                return CustomTextForm(
                  label: 'description',
                  valid: (val) {
                    return validInput(val!, 10, 30, 'des');
                  },
                  controller: createTaskControllerImp.description,
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
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "October 2023",
                      //     style: TextStyle(fontSize:15, height: 1.3),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 65,
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xfb3afaf),
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(color: Colors.black12)),
                      //   child: ListView.builder(
                      //       itemCount: createTaskControllerImp.day.length,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (context, i) {
                      //         return Container(
                      //           height: 50,
                      //           width: 60,
                      //           decoration: BoxDecoration(
                      //             color: (i == 0)
                      //                 ? Colors.purple.shade100
                      //                 : const Color(0xfe8e8e8),
                      //             borderRadius: BorderRadius.circular(10),
                      //             border: (i == 0)
                      //                 ? Border.all(color: Colors.purple.shade400)
                      //                 : null,
                      //           ),
                      //           child: Column(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceAround,
                      //             children: [
                      //               Text(
                      //                 "${i + 1}",
                      //                 style: const TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w500,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 createTaskControllerImp.day[i],
                      //                 style: const TextStyle(
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w500,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // ),
                      GetBuilder<CreateTaskControllerImp>(
                          builder: (createTaskControllerImp) {
                        return TableCalendar(
                          firstDay: DateTime(2022),
                          lastDay: DateTime(2026),
                          focusedDay: createTaskControllerImp.focusedDay,
                          calendarFormat: CalendarFormat.week,
                          calendarStyle: CalendarStyle(
                            //tablePadding: EdgeInsets.symmetric(horizontal: 20),
                            holidayDecoration: BoxDecoration(
                                color: Colors.cyan.shade400,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            rangeStartDecoration: BoxDecoration(
                                color: Colors.cyan.shade400,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            outsideDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38)),
                            defaultDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            weekendDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38)),
                            todayDecoration: BoxDecoration(
                                color: Colors.cyan.shade200,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            selectedDecoration: BoxDecoration(
                                color: Colors.cyan.shade400,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                          ),
                          onFormatChanged: (format) {
                            createTaskControllerImp.onFormatChanged(format);
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(
                                createTaskControllerImp.selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            createTaskControllerImp.onDaySelected(
                                selectedDay, focusedDay);
                          },
                        );
                      }),
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
                              return GetBuilder<CreateTaskControllerImp>(
                                  builder: (createTaskControllerImp) {
                                return InkWell(
                                  onTap: () {
                                    createTaskControllerImp.selectHour(
                                        index: i);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: createTaskControllerImp
                                            .hourColors[i],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: createTaskControllerImp
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
                            color: const Color(0xfb3afaf),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12)),
                        child: ListView.builder(
                            itemCount: createTaskControllerImp.day.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return GetBuilder<CreateTaskControllerImp>(
                                  builder: (createTaskControllerImp) {
                                return InkWell(
                                  onTap: () {
                                    createTaskControllerImp.selectDuration(
                                        index: i);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: createTaskControllerImp
                                            .durationColors[i],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: createTaskControllerImp
                                                .borderDurationColors[i])),
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
                                          style: TextStyle(
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
                          itemCount: createTaskControllerImp.repeats.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return GetBuilder<CreateTaskControllerImp>(
                                builder: (createTaskControllerImp) {
                              return InkWell(
                                onTap: () {
                                  createTaskControllerImp.selectRepeat(
                                      index: i);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        createTaskControllerImp.repeatColors[i],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: createTaskControllerImp
                                            .borderRepeatColors[i]),
                                  ),
                                  child: Text(
                                    createTaskControllerImp.repeats[i],
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
                        height: 28,
                      ),
                      InkWell(
                        onTap: () {
                          createTaskControllerImp.addTaskButton(context);
                          // createTaskControllerImp.sendNotification(title: 'title', body:'kjthfg', id: 'jkh');
                          createTaskControllerImp.sendNotify(
                              createTaskControllerImp.title.text,
                              createTaskControllerImp.description.text);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff096b6c)),
                          child: const Text(
                            "Create New Task",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
