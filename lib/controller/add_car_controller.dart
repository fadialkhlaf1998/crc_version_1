

import 'dart:io';

import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCarController extends GetxController{

  IntroController introController = Get.find();

  RxInt currentStep = 0.obs;
  TextEditingController search = TextEditingController();
  TextEditingController carPrice = TextEditingController();
  RxList<bool>? selectBrandIndex;
  RxInt? brandId;
  RxList<bool>? selectModelIndex;
  RxList<bool>? selectYearIndex;
  RxList<bool>? selectColorIndex;
  RxList<bool>? selectEmiratesIndex;
  RxInt brandIndex = 0.obs;
  RxInt modelIndex = 0.obs;
  List<int> yearModelList = List.filled(10, 0).obs;
  List<String> emirates = ['Dubai', 'Abu Dhabi', 'Ajman', 'Dubai Eye', 'Ras Al Khaimah','Sharjah','Umm Al Quwain'];
  List<String> emiratesPhoto = ['dubai.png', 'Abu_Dhabi.png', 'Ajman.png', 'Dubai_eye.png', 'Ras_Al_Khaimah.png', 'Sharjah.png','Umm_Al_Quwain.png'];
  final ImagePicker _picker = ImagePicker();
  RxList<File> imageList = <File>[].obs;


  /// Variable to send to the server */
  String? yearModelSelect;
  String? colorSelect;
  String? emiratesSelect;
  String? brand;
  String? model;



  @override
  void onInit() {
    super.onInit();
    selectBrandIndex = List.filled(introController.brands.length, false).obs;
    selectBrandIndex![0] = true;
    selectYearIndex = List.filled(10, false).obs;
    selectColorIndex = List.filled(introController.colors.length, false).obs;
    selectEmiratesIndex = List.filled(emirates.length, false).obs;
  }

  selectBrand(index){
    for(int i = 0; i < selectBrandIndex!.length; i++){
      selectBrandIndex![i] = false;
    }
    selectBrandIndex![index] = true;
    brandIndex.value = index;
  }

  selectModel(index){
    for(int i = 0; i < selectModelIndex!.length; i++){
      selectModelIndex![i] = false;
    }
    selectModelIndex![index] = true;
    modelIndex.value = index;
  }

  fillYearList(){
    int year = DateTime.now().year + 1;
    for(int i = 0; i < 10; i++){
      yearModelList[i] = year;
      year --;
    }
  }

  selectYear(index){
    for(int i =0; i < selectYearIndex!.length; i++){
      selectYearIndex![i] = false;
    }
    selectYearIndex![index] = true;
    yearModelSelect = yearModelList[index].toString();
  }

  selectColor(index){
    for(int i = 0; i < selectColorIndex!.length; i++){
      selectColorIndex![i] = false;
    }
    selectColorIndex![index] = true;
    colorSelect = introController.colors[index].title;
  }

  selectEmirates(index){
    for(int i = 0; i < emirates.length; i++){
      selectEmiratesIndex![i] = false;
    }
    selectEmiratesIndex![index] = true;
    emiratesSelect = emirates[index];
  }

  Future selectImage()async{
    _picker.pickImage(source: ImageSource.gallery).then((value){
      imageList.add(File(value!.path));
    });
  }

  deleteImageFromList(index){
    imageList.removeAt(index);
  }


  forwardStep(context){

      if(currentStep.value == 0){
        brand = introController.brands[brandIndex.value].title;
        selectModelIndex = List.filled(introController.brands[brandIndex.value].models.length, false).obs;
        selectModelIndex![0] = true;
        currentStep.value +=1;
      }
      else if(currentStep.value == 1){
        model = introController.brands[brandIndex.value].models[modelIndex.value].title;
        fillYearList();
        currentStep.value +=1;
      }
      else if(currentStep.value == 2){
        if(yearModelSelect == null){
          App.info_msg(context, 'you must choose year model');
        }else{
          currentStep.value +=1;
        }
      }
      else if(currentStep.value == 3){
        if(colorSelect == null){
          App.info_msg(context, 'You must choose color');
        }else{
          currentStep.value +=1;
        }
      }
      else if(currentStep.value == 4){
        if(emiratesSelect == null){
          App.info_msg(context, 'You must choose emirates');
        }else{
          currentStep.value += 1;
        }
      }
      else if(currentStep.value == 5){
        if(imageList.length < 3){
          App.info_msg(context, 'You must upload at least three photos');
        }else{
          currentStep.value += 1;
        }
      }
      else if(currentStep.value == 6){
        if(carPrice.text.isEmpty){
          App.info_msg(context, 'You must enter the price');
        }else{
          /** Upload Information*/
        }
      }
    }

  backwardStep(){
    if(currentStep.value <= 0){

    }else{
      currentStep.value -=1;
    }
  }

}