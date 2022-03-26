import 'package:flutter/material.dart';


class Validation {

  static String? emailValidation(String? email) {
    if(email==null||email.isEmpty){
      return "Please Enter Email";
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
     if(regex.hasMatch(email)){
       return null;
     } else{
       return "Enter Valid Email";
     }
  }


  static String? PasswordVarification(String? password) {
    if(password==null||password.isEmpty){
      return "Please Enter Password";
    } else if(password.length <6) {
      return "Minimum 6 Character Requried";
    }
    else {
      null;
    }
}

 static String? registerNameVaidation(String? name){
    if(name==null||name.isEmpty){
      return "Please Enter Name";
    } else return null;
 }

  static String? registerEmailvalidation(String? email){
    if(email==null||email.isEmpty){
      return "Please Enter Email";
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if(regex.hasMatch(email)){
      return null;
    } else{
      return "Enter Valid Email";
    }
  }

  static String? registerPasswordValidation(String? password){
    if(password==null||password.isEmpty){
      return "Please Enter Password";
    } else if(password.length <6) {
      return "Minimum 6 Character Requried";
    }
    else {
      null;
    }
    return null;
  }



}