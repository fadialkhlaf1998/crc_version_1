import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{

  final isDialOpen = ValueNotifier(false);
  RxBool mode_value = MyTheme.isDarkTheme.obs;


  changeMode(){
    myTheme.toggleTheme();
    mode_value.value = !mode_value.value;
  }

  logout(){
    Store.logout();
    Get.offAll(()=>LogIn());
  }

}