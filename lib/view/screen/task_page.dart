import 'package:caregiver_app/view/widget/custom_task_widget_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../controller/task_page_controller.dart';
import '../../core/constant/colors.dart';
import '../widget/custom_container_widget.dart';
import '../widget/custom_task_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskPageControllerImp taskPageControllerImp =
        Get.put(TaskPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Tasks"),
        centerTitle: true,
        backgroundColor: Color(0xff096b6c),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskPageControllerImp.goToCreateNewTaskController();
        },
        backgroundColor: Color(0xff096b6c),
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: 660,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomContainerWidget(
              widget: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.task_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Alzheimer Task",
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
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.yellow,
                child: StreamBuilder(
                    stream: taskPageControllerImp.getPatientTask(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GetBuilder<TaskPageControllerImp>(
                            builder: (taskPageControllerImp) {
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, i) {
                                if (taskPageControllerImp.isClick[i] == false) {
                                  return Container(
                                    height: 130,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Slidable(
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.5,
                                          children: [
                                            SlidableAction(
                                              onPressed: (c) {
                                                taskPageControllerImp
                                                    .deleteTask(context,
                                                        taskId: snapshot
                                                            .data.docs[i]
                                                            .data()['taskId']);
                                              },
                                              backgroundColor:
                                                  const Color(0x84FF0000),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              label: 'Delete',
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SlidableAction(
                                              onPressed: (c) {
                                                taskPageControllerImp
                                                    .goToEditTask(
                                                        taskId: snapshot
                                                            .data.docs[i]
                                                            .data()['taskId']);
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              backgroundColor:
                                                  const Color(0x8CF8EB65),
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: 'Edit',
                                            ),
                                          ],
                                        ),
                                        child:
                                            GetBuilder<TaskPageControllerImp>(
                                          builder: (taskPageControllerImp) {
                                            return CustomTaskWidget(
                                              color1: colorsGradient[i][0],
                                              color2: colorsGradient[i][1],
                                              taskId:
                                                  "${snapshot.data.docs[i].data()['taskId']}",
                                              onPressed: () {
                                                taskPageControllerImp
                                                    .changeWidget(index: i);
                                              },
                                              icon: Icons.arrow_circle_down,
                                              isActive: snapshot.data.docs[i]
                                                  .data()['isActive'],
                                              onChange: (val) {
                                                taskPageControllerImp.onChange(
                                                    isActive: val,
                                                    taskId:
                                                        "${snapshot.data.docs[i].data()['taskId']}");
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 260,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Slidable(
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.5,
                                          children: [
                                            SlidableAction(
                                              onPressed: (c) {
                                                taskPageControllerImp
                                                    .deleteTask(context,
                                                        taskId: snapshot
                                                            .data.docs[i]
                                                            .data()['taskId']);
                                              },
                                              backgroundColor:
                                                  const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              label: 'Delete',
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SlidableAction(
                                              onPressed: (c) {
                                                taskPageControllerImp
                                                    .goToEditTask(
                                                        taskId: snapshot
                                                            .data.docs[i]
                                                            .data()['taskId']);
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              backgroundColor:
                                                  const Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: 'Edit',
                                            ),
                                          ],
                                        ),
                                        child:
                                            GetBuilder<TaskPageControllerImp>(
                                          builder: (taskPageControllerImp) {
                                            return CustomTaskWidgetDetails(
                                              taskDes:
                                                  "${snapshot.data.docs[i].data()['description']}",
                                              taskHour:
                                                  "${snapshot.data.docs[i].data()['hour']}",
                                              taskTitle:
                                                  "${snapshot.data.docs[i].data()['title']}",
                                              color1: colorsGradient[i][0],
                                              color2: colorsGradient[i][1],
                                              taskId:
                                                  "${snapshot.data.docs[i].data()['taskId']}",
                                              onPressed: () {
                                                taskPageControllerImp
                                                    .changeWidget(index: i);
                                              },
                                              icon: Icons.arrow_circle_up,
                                              isActive: snapshot.data.docs[i]
                                                  .data()['isActive'],
                                              onChange: (val) {
                                                taskPageControllerImp.onChange(
                                                    isActive: val,
                                                    taskId:
                                                        "${snapshot.data.docs[i].data()['taskId']}");
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              });
                        });
                      } else if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff096b6c),
                        ));
                      } else {
                        return const Text("no tasks available");
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
