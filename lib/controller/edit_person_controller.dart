import 'dart:developer';
import 'dart:io';
import 'package:crc_version_1/controller/add_people_controller.dart';
import 'package:crc_version_1/controller/people_list_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/view/people_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPersonController extends GetxController{
  
  PeopleListController peopleListController = Get.find();
  AddPeopleController addPeopleController = Get.put(AddPeopleController());

  RxInt personIndex = 0.obs;
  RxBool editNameList = false.obs;
  RxBool editNumberList = false.obs;
  RxBool editLanguageList = false.obs;
  TextEditingController? editingNameController;
  TextEditingController? editingNumberController;
  List allLanguages = [];
  RxList myLanguage = [].obs;
  final ImagePicker _picker = ImagePicker();
  RxList<File> personImage = <File>[].obs;
  RxInt checkImageChange = 0.obs;


  RxList<bool>? languageCheck;
  RxBool loading = false.obs;

  /// Edit Variable
  RxString? name;
  RxString? phone;
  RxString? languages;
  RxList<File> newImage = <File>[].obs;
  int personId = -1;


  @override
  void onInit() {
    super.onInit();
    personIndex.value = peopleListController.currentIndex!.value;
    name = peopleListController.myPeopleList[personIndex.value].name.obs;
    phone = peopleListController.myPeopleList[personIndex.value].phone.obs;
    myLanguage = peopleListController.myPeopleList[personIndex.value].languages.split(' / ').obs;
    languages = myLanguage.join(' / ').obs;
    personId = peopleListController.myPeopleList[personIndex.value].id;
    personImage.add(File(peopleListController.myPeopleList[personIndex.value].image));
    editingNameController = TextEditingController(text: name!.value);
    editingNumberController = TextEditingController(text: phone!.value);
    allLanguages = addPeopleController.language;
    languageCheck = List.filled(allLanguages.length, false).obs;
   // myLanguage.value = peopleListController.myPeopleList[personIndex.value].languages.split(' / ');
    for(int i = 0; i < allLanguages.length; i++){
      if (myLanguage.contains(allLanguages[i])){
        languageCheck![i] = true;
      }
    }
  }

  editName(){
    editNameList.value = !editNameList.value;
  }
  editNumber(){
    editNumberList.value = !editNumberList.value;
  }
  editLanguage(){
    editLanguageList.value = !editLanguageList.value;
  }

  getNewName(v){
    name!.value = v;
  }

  getNewPhone(v){
    phone!.value = v;
  }

  getNewLanguages(){
    languages = myLanguage.join(' / ').obs;
  }

  changePersonImage(){
    _picker.pickImage(source: ImageSource.gallery).then((value){
      if(value != null){
        checkImageChange.value = 1;
        if(newImage.isEmpty){
          newImage.add(File(value.path));
        }else if(newImage.isNotEmpty){
          newImage[0] = File(value.path);
        }
      }else{

      }
    });
  }

  deletePersonImage(){
    checkImageChange.value = 2;
    if(newImage.isEmpty){
      newImage.add(File('assets/images/profile_picture.png'));
      Get.back();
    }else if (newImage.isNotEmpty){
      newImage[0] = File('assets/images/profile_picture.png');
      Get.back();
    }


  }

  changeLanguage(index){
    if(languageCheck![index] == false){
      languageCheck![index] = true;
      myLanguage.add(allLanguages[index]);
      print(myLanguage.length);
      for(int i = 0 ; i < myLanguage.length; i++ ){
        print(myLanguage[i]);
      }
    }else if(languageCheck![index] == true){
      languageCheck![index] = false;
      myLanguage.removeAt(myLanguage.indexOf(allLanguages[index]));
      print(myLanguage.length);
      for(int i = 0 ; i < myLanguage.length; i++){
        print('-' + myLanguage[i] + '-');
      }
    }
    if(myLanguage.isEmpty){
      languages = ''.obs;
    }else{
      languages = myLanguage.join(' / ').obs;
    }

  }

  savePersonInformation(){
    loading.value = true;
    Api.check_internet().then((internet){
      if(internet){
        if(newImage.isNotEmpty){
          personImage[0] = File(newImage[0].path);
        }
        Api.updatePersonInformation(
            name!.value,
            phone!.value,
            languages!.value,
            Global.company_id.toString(),
            personId.toString(),
            personImage[0],
            checkImageChange.value
        ).then((value){
          if(value == true){
            loading.value = false;
            Get.back();
            peopleListController.getInfo(Global.company_id);
          }else{
            loading.value = false;
          }
        });
      }else{
        loading.value = false;
      }
    });
    //loading.value = false;
  }



}