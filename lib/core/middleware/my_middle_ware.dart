
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/routes.dart';
import '../services/services.dart';

class MyMiddleWare extends GetMiddleware{

 MyServices myServices = Get.find();

 @override

  int? get priority => 1;

 @override
 RouteSettings? redirect(String? route) {

  if(myServices.sharedPreferences.getBool('isLogin') == true){
                  print('================true=============');
    return const RouteSettings(name: AppRoutes.homePage);

  }

 }
}