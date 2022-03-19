import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/view/people_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
  double? companyID;
  RxBool loadingUpload = false.obs;


  @override
  void onInit() {
    super.onInit();
    companyID = Global.company_id.toDouble();
  }

  selectLanguage(index) {
    select[index] = !select[index];
  }

  forwardStep(context)async{
    if(currentStep.value >= 3){
      selectLanguages = '';
      for(int i = 0; i < select.length; i++){
        if(select[i] == true && selectLanguages != ''){
          selectLanguages += ' / ' + language[i];
        }else if(select[i] == true){
          selectLanguages += language[i];
        }
      }
      currentStep.value += 1;
      loadingUpload.value = true;
      Api.addPerson(username.text, userImage.first, mobileNumber.text, selectLanguages, companyID!);
      Future.delayed(const Duration(milliseconds: 1500),(){
        loadingUpload.value = false;
        Get.off(()=>PeopleList());
      });
    }
    else if(currentStep.value == 0){
      if( username.text.isEmpty){
        App.info_msg(context, 'Name can\'t be empty');
      }else{
        currentStep.value +=1;
      }
    }
    else if (currentStep.value == 1){
      if(userImage.isEmpty){
        final byteData = await rootBundle.load('assets/images/profile_picture.png');
        final file = File('${(await getTemporaryDirectory()).path}/profile_picture.png');
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        userImage.add(file);
      }
      currentStep.value +=1;
    }
    else if(currentStep.value == 2){
      if(mobileNumber.text.isEmpty){
        App.info_msg(context, 'Mobile number is necessary');
      }else{
        currentStep.value +=1;
      }
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