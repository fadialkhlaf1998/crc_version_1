
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/view/home.dart';
import 'package:crc_version_1/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var loading = false.obs;
  var submited = false.obs;
  var sign_up_option = false.obs;

  submite(BuildContext context){
    loading.value = true;
    Api.check_internet().then((internet) {
      if(internet){
        if(username.text.isNotEmpty&&password.text.isNotEmpty){
          submited.value=true;
          Api.login(username.text, password.text).then((value) {
            if(value!=-1){
              Global.loginInfo!.email=username.text;
              Global.loginInfo!.pass=password.text;
              Store.Save_login();
              Global.company_id=value;
              Get.offAll(()=>Home());
            }else{
              ///Wrong email pr password
              loading.value = false;
              App.error_msg(context, "Wrong Email or password");
            }
          }).catchError((err){
            print(err);
            loading.value=false;
          });
        }else{
          submited.value=true;
        }
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          submite(context);
        });
      }
    });


  }

}