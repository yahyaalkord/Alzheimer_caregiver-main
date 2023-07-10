

import 'package:get/get.dart';

validInput(String value,int min,int max,String type){

  if(type == "username"){
    if(!GetUtils.isUsername(value)){
      return "not valid username";
    }

  }
  if(type == "phone"){
    if(!GetUtils.isPhoneNumber(value)){
      return "not valid phone number";
    }
    if(value.length!= 10){
      return "not valid phone number";
    }
  }
  if(type == "email"){
    if(!GetUtils.isEmail(value)){
      return "not valid email";
    }

  }
  if(type == "phone"){
    if(!GetUtils.isPhoneNumber(value)){
      return "not valid phone number";
    }

  }

  if(value.length<min){
    return "value can not less than $min";
  }
  if(value.length>max){
    return "value can not larger than $max";
  }
  if(value.isEmpty){
    return " can not be empty";
  }
}