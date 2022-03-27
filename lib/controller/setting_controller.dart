
import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/main.dart';
import 'package:crc_version_1/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController{

  CarListController carListController = Get.put(CarListController());

  Rx<MyTheme> myTheme = MyTheme().obs;
  final isDialOpen = ValueNotifier(false);
  final ImagePicker _picker = ImagePicker();
  var currentLanguage = 'English'.obs;


  @override
  void onInit() {
    super.onInit();
    if(Global.lang_code == "en"){
      currentLanguage.value = 'English';
    }else{
      currentLanguage.value = 'العربية';
    }
  }

  List languages = [
    {
      "name" : "English",
      "id" : "en"
    },
    {
      "name" : "Arabic",
      "id" : "ar"
    }
  ];

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

  changeCompanyImage(){
    _picker.pickImage(source: ImageSource.gallery).then((value){
      /// Edit Image
    });
  }

  changeLanguage(BuildContext context, String language){
    MyApp.set_local(context,Locale(language));
    Get.updateLocale(Locale(language));
    Global.save_language(language);
    Global.load_language();
  }

}