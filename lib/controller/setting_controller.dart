import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/main.dart';
import 'package:crc_version_1/view/cars_list.dart';
import 'package:crc_version_1/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{

  CarListController carListController = Get.put(CarListController());

  Rx<MyTheme> myTheme = MyTheme().obs;
  final isDialOpen = ValueNotifier(false);
  // RxBool mode_value = MyTheme.isDarkTheme.obs;


  changeMode(BuildContext context){
    myTheme.value.toggleTheme();
    MyApp.set_theme(context);
  }

  logout(){
    Store.logout();
    Get.offAll(()=>LogIn());
  }

  goToCarList(){
    carListController.updateCarList();
    Get.back();
  }

}