import 'package:caregiver_app/controller/fb_storage_controller.dart';
import 'package:caregiver_app/view/screen/add_diary_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widget/custom_container_widget.dart';

class PatientDiaryScreen extends StatefulWidget {
  const PatientDiaryScreen({required this.id, Key? key}) : super(key: key);
  final String id;

  @override
  State<PatientDiaryScreen> createState() => _PatientDiaryScreenState();
}

class _PatientDiaryScreenState extends State<PatientDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Diary"),
        centerTitle: true,
        backgroundColor: const Color(0xff096b6c),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddDiaryScreen(
                id: widget.id,
              );
            },
          ));
        },
        backgroundColor: const Color(0xff096b6c),
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: 660,
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
                        Icons.task_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Alzheimer Diary",
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                // color: Colors.yellow,
                child: FutureBuilder<List<Reference>>(
                  future: FbStorageController().read(id: widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Reference> items = snapshot.data!;
                      return RefreshIndicator(
                        onRefresh: () => refresh(),
                        child: ListView.builder(
                          padding: EdgeInsetsDirectional.only(bottom: 300),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<String>(
                              future: items[index].getDownloadURL(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  String imageUrl = snapshot.data!;
                                  return Container(
                                    height: 130,
                                    padding: EdgeInsetsDirectional.only(start: 10),
                                    margin: const EdgeInsetsDirectional.only(
                                        bottom: 10, start: 16, end: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff096b6c),
                                            Color(0xff207979),
                                            Color(0xff388c8c),
                                            Color(0xff5ab9b9),


                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  50),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Image.network(imageUrl,fit: BoxFit.cover,),
                                        ),
                                        SizedBox(width: 30,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person,size: 30,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Text('${items[index].name.split('.')[1]}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                Icon(Icons.account_tree,size: 30,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Text('${items[index].name.split('.')[2]}',style: TextStyle(fontSize: 20,color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('حدث خطأ في الحصول على الصورة');
                                } else {
                                  return SizedBox();
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // حدث خطأ أثناء استرداد البيانات
                      return Text('حدث خطأ: ${snapshot.error}');
                    } else {
                      // جارٍ استرداد البيانات
                      return Center(
                        child: SizedBox(
                          height: 100,
                            width: 100,
                            child: CircularProgressIndicator()),
                      );
                    }
                  },
                )

                /*   StreamBuilder<List<Reference>>(
    stream: FbStorageController().read(id: widget.id),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    List<Reference> items = snapshot.data!;
    // قائمة الملفات المستردة متوفرة هنا
    return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
    // استخدم items[index] للوصول إلى معلومات الملف الفردي
    return Container(
    height: 130,
    margin: const EdgeInsetsDirectional.only(bottom: 10,start: 16,end: 16),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
    colors: [
    Color(0xff096b6c),
    Color(0xff207979),
    Color(0xff388c8c),
    Color(0xff5ab9b9),
    Color(0xff8becec),


    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    )
    ),
    child: Row(
    children: [
    Container(
    clipBehavior: Clip.antiAlias,
    height: 120,
    width: 120,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60),
    border: Border.all(color: Colors.white)),
    child: Image.network(items[index].),
    )
    ],
    ),
    );
    },
    );
    } else if (snapshot.hasError) {
    return Text('حدث خطأ: ${snapshot.error}');
    } else {
    return const CircularProgressIndicator();
    }
    },
    )*/
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> refresh() async{
    setState(() {

    });
  }
}
