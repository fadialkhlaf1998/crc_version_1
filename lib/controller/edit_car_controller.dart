
import 'dart:io';

import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/controller/my_car_list_controller.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditCarController extends GetxController{

  IntroController introController = Get.find();
  MyCarListController myCarListController = Get.find();

  RxString? brand;
  RxString? model;
  RxString? year;
  RxString? color;
  RxString? price;
  RxString? id;
  RxString? location;
  RxInt? brandIndex;
  RxBool imagePage = false.obs;

  RxList<File> imageList = <File>[].obs;

  List<String> emirates = ['Dubai', 'Abu Dhabi', 'Ajman', 'Dubai Eye', 'Ras Al Khaimah','Sharjah','Umm Al Quwain'];
  List<String> emiratesPhoto = ['dubai.png', 'Abu_Dhabi.png', 'Ajman.png', 'Dubai_eye.png', 'Ras_Al_Khaimah.png', 'Sharjah.png','Umm_Al_Quwain.png'];
  RxList<bool> emiratesCheck =  List.filled(7, false).obs;

  RxList<Brands> brands = <Brands>[].obs;
  RxString? image;
  RxBool editPriceOpenList = false.obs;
  RxBool editLocationOpenList = false.obs;
  RxBool editImageList = false.obs;
  TextEditingController? editingController;



  @override
  void onInit() {
    brands = introController.brands.obs;
   brand = myCarListController.brand;
   model = myCarListController.model;
   year = myCarListController.year;
   color = myCarListController.color;
   price = myCarListController.price;
   id = myCarListController.id;
   editingController =  TextEditingController(text: price!.value);
   location = myCarListController.location;

   for(int i = 0; i < emirates.length; i++){
     if(emirates[i] == location!.value){
       emiratesCheck[i] = true;
     }
   }

   for(int i = 0; i < brands.length; i++){
     if(brands[i].title == brand!.value){
       image = brands[i].image.obs;
     }
   }
  }

  fillCarImage(){

  }

  editPrice(){
    editPriceOpenList.value = !editPriceOpenList.value;
  }
  editLocation(){
    editLocationOpenList.value = !editLocationOpenList.value;
  }

  getNewPrice(){
    price!.value = editingController!.text;
  }

  getNewLocation(index){
    location!.value = emirates[index];
    for(int i = 0; i < emiratesCheck.length; i++){
      emiratesCheck[i] = false;
    }
    emiratesCheck[index] = true;
  }




}