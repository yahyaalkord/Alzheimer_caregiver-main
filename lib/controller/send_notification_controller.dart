import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

abstract class SendNotificationController extends GetxController {
  sendNotification(
      {required String title, required String body, required String id});
}

class SendNotificationControllerImp extends SendNotificationController {
  final String serverToken =
      'AAAAdFkfDgg:APA91bHvTCTNh3q5SS6J-Vgq3MnjNiXrlLwVeRRT4v715ihiNibczNDIqGom3pqu8IIm6boSvqM7bllG2sgItU9dpgfjACEYmms5AY4lbqHBxozbn_W4qrd18BvNZ8upIRrQbCa5vdPX';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  sendNotification(
      {required String title, required String body, required String id}) async {
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
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }

  getMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      print('==============================');
      print('${event.notification!.body}');
      print('===============================');
    });
  }

  @override
  void onInit() {
    sendNotification(title: "Hello ", body: 'nesma', id: 'ccccccccccccccccc');
    getMessage();
    super.onInit();
  }
}
