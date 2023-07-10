import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constant/routes.dart';
import '../core/services/services.dart';
import '../model/task_model.dart';

abstract class CreateTaskController extends GetxController {
  Future<void> addTask({required TaskModel taskModel});

  sendNotification(
      {required String title, required String body, required String id});
}

class CreateTaskControllerImp extends CreateTaskController {
  List<String> day = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"];
  List<Color> hourColors = List.filled(24, Colors.white);
  List<Color> borderHourColors = List.filled(24, Colors.white);
  List<Color> repeatColors = List.filled(24, const Color(0xfcf1f1f1));
  List<Color> borderRepeatColors = List.filled(24, Colors.white);
  List<Color> durationColors = List.filled(24, const Color(0xfcf1f1f1));
  List<Color> borderDurationColors = List.filled(24, Colors.white);
  List<String> repeats = [
    'No repeat',
    'Every day',
    'Every 2 day',
    'Every week'
  ];

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  MyServices myServices = Get.find();
  late TextEditingController title;
  late TextEditingController description;
  String hour = "3:00";
  String repeat = "No repeat";
  int duration = 2;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? taskId;
  final String serverToken =
      'AAAAdFkfDgg:APA91bHvTCTNh3q5SS6J-Vgq3MnjNiXrlLwVeRRT4v715ihiNibczNDIqGom3pqu8IIm6boSvqM7bllG2sgItU9dpgfjACEYmms5AY4lbqHBxozbn_W4qrd18BvNZ8upIRrQbCa5vdPX';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //List<String> time = ["1:00","Sat","Sun","Mon","Tue","Wed","Thu"];
  void selectRepeat({required int index}) {
    repeatColors = List.filled(24, const Color(0xfcf1f1f1));
    borderRepeatColors = List.filled(24, Colors.white);
    borderRepeatColors[index] = Colors.cyan.shade400;
    repeatColors[index] = Colors.purple.shade100;
    repeat = repeats[index];
    update();
  }

  void selectDuration({required int index}) {
    durationColors = List.filled(24, const Color(0xfcf1f1f1));
    borderDurationColors = List.filled(24, Colors.white);
    borderDurationColors[index] = Colors.blue.shade400;
    durationColors[index] = Colors.blue.shade100;
    duration = index + 1;
    update();
  }

  void selectHour({required int index}) {
    hourColors = List.filled(24, Colors.white);
    borderHourColors = List.filled(24, Colors.white);
    borderHourColors[index] = Colors.yellow.shade400;
    hourColors[index] = Colors.yellow.shade100;
    hour = '${index + 1}:00';
    update();
  }

  @override
  Future<void> addTask({required TaskModel taskModel}) async {
    myServices.collectionReferenceTask
        .doc(taskId)
        .set(
          taskModel.toMap(),
        )
        .then((value) {
      print('SUCCESS ADD TASK');
    }).catchError((e) {
      print('FAIL ADD TASK');
    });
  }

  onFormatChanged(dynamic format) {
    calendarFormat = format;
    update();
  }

  onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay; // update `_focusedDay` here as well
      update();
    }
  }

  // void addTaskButton(context) {
  //   var formData = formState.currentState;
  //   if (formData!.validate()) {
  //     taskId =
  //         DateTime.now().hour.toString() + Random().nextInt(100).toString();
  //     addTask(
  //             taskModel: TaskModel(
  //                 patientId: myServices.patientId!,
  //                 taskId: taskId!,
  //                 caregiverId: myServices.caregiverId!,
  //                 title: title.text,
  //                 description: description.text,
  //                 startDate: selectedDay!,
  //                 duration: duration,
  //                 endDate: selectedDay!.add(Duration(days: duration * 7)),
  //                 hour: hour,
  //                 repeat: repeat,
  //                 isActive: false))
  //         .then((value) {
  //       AwesomeDialog(
  //         context: context,
  //         dialogType: DialogType.success,
  //         animType: AnimType.rightSlide,
  //         title: 'Add Task',
  //         desc: 'SUCCESS REGISTER Task',
  //         btnCancelOnPress: () {},
  //         btnOkOnPress: () {
  //           Get.offAllNamed(AppRoutes.taskPage);
  //         },
  //       ).show();
  //     });
  //   } else {
  //     print('not valid');
  //   }
  // }

  void addTaskButton(context) {
    var formData = formState.currentState;
    if (formData!.validate()) {
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        selectedDay!.year,
        selectedDay!.month,
        selectedDay!.day,
        int.parse(hour.split(':')[0]),
        0,
      );

      if (selectedDateTime.isBefore(now)) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Invalid Start Date',
          desc: 'The start date cannot be before the current time.',
          btnOkOnPress: () {},
        ).show();
        return;
      }

      taskId = now.hour.toString() + Random().nextInt(100).toString();
      addTask(
        taskModel: TaskModel(
          patientId: myServices.patientId!,
          taskId: taskId!,
          caregiverId: myServices.caregiverId!,
          title: title.text,
          description: description.text,
          startDate: selectedDay!,
          duration: duration,
          endDate: selectedDay!.add(Duration(days: duration * 7)),
          hour: hour,
          repeat: repeat,
          isActive: false,
        ),
      ).then((value) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Add Task',
          desc: 'SUCCESS REGISTER Task',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Get.offAllNamed(AppRoutes.taskPage);
          },
        ).show();
      });
    } else {
      print('Form is not valid');
    }
  }

  @override
  sendNotification(
      {required String title, required String body, required String id}) async {
    final patientFCMToken = myServices.patientFCMToken;

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id,
            'status': 'done'
          },
          'to': patientFCMToken,
          // 'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }

  sendNotify(title, body) {
    Future.delayed(Duration(minutes: 1), () {
      sendNotification(
          title: title, body: body, id: myServices.collectionReferenceTask.id);
    });
  }

  @override
  void onInit() {
    title = TextEditingController();
    description = TextEditingController();
    selectedDay = focusedDay;
    borderHourColors[2] = Colors.yellow.shade400;
    hourColors[2] = Colors.yellow.shade100;
    borderRepeatColors[0] = Colors.purple.shade200;
    repeatColors[0] = Colors.purple.shade100;
    borderDurationColors[3] = Colors.blue.shade400;
    durationColors[3] = Colors.blue.shade100;
    super.onInit();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }
}
