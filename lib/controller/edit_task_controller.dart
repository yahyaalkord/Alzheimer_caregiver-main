import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';

abstract class EditTaskController extends GetxController {
  Future<void> editTask();
}

class EditTaskControllerImp extends EditTaskController {
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
  MyServices myServices = Get.find();
  String? title;
  String? description;

  String? hour;
  String? repeat;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? taskId;
  int? duration;

  void selectRepeat({required int index}) {
    repeatColors = List.filled(24, const Color(0xfcf1f1f1));
    borderRepeatColors = List.filled(24, Colors.white);
    borderRepeatColors[index] = Colors.cyan.shade400;
    repeatColors[index] = Colors.cyan.shade100;
    repeat = repeats[index];
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

  void selectDuration({required int index}) {
    durationColors = List.filled(24, const Color(0xfcf1f1f1));
    borderDurationColors = List.filled(24, Colors.white);
    borderDurationColors[index] = Colors.blue.shade400;
    durationColors[index] = Colors.blue.shade100;
    duration = index + 1;
    update();
  }

  @override
  Future<void> editTask() async {
    myServices.collectionReferenceTask.doc(myServices.taskId).update({
      'description': description,
      'duration': duration,
      'hour': hour,
      'repeat': repeat,
      'title': title,
    }).then((value) {
      print('SUCCESS ADD TASK');
    }).catchError((e) {
      print('FAIL ADD TASK');
    });
  }

  void editTaskButton(context) {
    var formData = formState.currentState;
    if (formData!.validate()) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        title: 'Update Task data',
        desc: 'Your Sure Update Task Data',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          editTask();
          Get.toNamed(AppRoutes.taskPage);
        },
      ).show();
    } else {
      print('not valid');
    }
  }

  void test() async {
    var request = await myServices.collectionReferenceTask
        .where('taskId', isEqualTo: myServices.taskId)
        .get();
    // for(var req in request.docs){
    Map<String, dynamic> data = request.docs[0].data() as Map<String, dynamic>;
    hour = data['hour'];
    duration = data['duration'];
    repeat = data['repeat'];
    title = data['title'];
    description = data['description'];
    for (int i = 0; i <= repeats.length; i++) {
      if (repeats[i] == repeat) {
        borderRepeatColors[i] = Colors.purple.shade200;
        repeatColors[i] = Colors.purple.shade100;
        break;
      }
    }
    for (int i = 0; i <= 23; i++) {
      if ('${(i + 1).toString()}:00' == hour) {
        borderHourColors[i] = Colors.yellow.shade400;
        hourColors[i] = Colors.yellow.shade100;
        break;
      }
    }
    borderDurationColors[duration! - 1] = Colors.blue.shade400;
    durationColors[duration! - 1] = Colors.blue.shade100;
    update();

    //}
  }

  Stream<QuerySnapshot<Object?>> getPatientTaskInfo() {
    return myServices.collectionReferenceTask
        .where("taskId", isEqualTo: myServices.taskId)
        .snapshots();
  }

  @override
  void onInit() {
    test();
    super.onInit();
  }
}
