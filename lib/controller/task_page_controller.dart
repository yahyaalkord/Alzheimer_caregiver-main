
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/services/services.dart';

abstract class TaskPageController extends GetxController{

  goToCreateNewTaskController();
}

class TaskPageControllerImp extends TaskPageController{
  MyServices myServices = Get.find();
  List<bool> isClick =[false,false,false,false,false,false,false,false];


  Stream<QuerySnapshot<Object?>> getPatientTask(){
    return myServices.collectionReferenceTask.where(
        "patientId",isEqualTo: myServices.patientId
    ).snapshots();
  }
  void goToEditTask({required String taskId}){
    myServices.taskId = taskId;
    Get.toNamed(AppRoutes.editTask);
  }
  void deleteTask(BuildContext context,{required String taskId}){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'delete Task',
      desc: 'your sure delete Task',
      btnCancelOnPress: () {


      },
      btnOkOnPress: () async {
        await myServices.collectionReferenceTask.doc(taskId).delete();

      },
    ).show();


  }
  onChange({required bool isActive,required String taskId}){

      myServices.collectionReferenceTask.doc(taskId).update(
        {
          "isActive":isActive
        }
      ).then((value){
        print('success');
      }).catchError((e){
        print('r');
      });
      update();


  }
  changeWidget({required int index}){

     isClick[index] = !isClick[index];
      update();
     print(isClick[index]);
  }
  @override
  goToCreateNewTaskController() {

    Get.toNamed(AppRoutes.createNewTask);
  }

}