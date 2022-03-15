import 'package:crc_version_1/helper/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddPeopleController extends GetxController{

  RxInt currentStep = 0.obs;

  RxList language = ['English', 'Arabic','French'].obs;
  RxList select = [false, false, false].obs;
  String selectLanguages = '';
  final ImagePicker _picker = ImagePicker();
  TextEditingController username = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  List<File> userImage = <File>[].obs;

  selectLanguage(index) {
    select[index] = !select[index];
  }

  forwardStep(context){
    if(currentStep.value >= 3){
      selectLanguages = '';
      for(int i = 0; i < select.length; i++){
        if(select[i] == true && selectLanguages != ''){
          selectLanguages += ' / ' + language[i];
        }
          selectLanguages += language[i];
        }

    }
    else if(currentStep.value == 0){
      //RegExp exp = RegExp(r"\s+");
      if( username.text.isEmpty){
        App.info_msg(context, 'Name can\'t be empty');
      }else{
        currentStep.value +=1;
      }
    }
    else if(currentStep.value == 2){
      if(mobileNumber.text.isEmpty){
        App.info_msg(context, 'Mobile number is necessary');
      }else{
        currentStep.value +=1;
      }
    }
    else{
      currentStep.value +=1;
    }

  }

  backwardStep(){
    if(currentStep.value <= 0){

    }else{
      currentStep.value -=1;
    }
  }

  Future selectImage()async{
    _picker.pickImage(source: ImageSource.gallery).then((value){
      userImage.add(File(value!.path));
    });
  }


}