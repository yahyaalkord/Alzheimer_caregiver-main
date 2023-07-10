import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/send_notification_controller.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendNotificationControllerImp sendNotificationControllerImp =
        Get.put(SendNotificationControllerImp());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await sendNotificationControllerImp.sendNotification(
                      title: 'Hello', body: 'I\'m nesma', id: '1');
                  sendNotificationControllerImp.getMessage();
                },
                child: const Text(
                  "send",
                  style: TextStyle(fontSize: 30),
                ))
          ],
        ),
      ),
    );
  }
}
