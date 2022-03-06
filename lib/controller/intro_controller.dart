import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:crc_version_1/view/home.dart';
import 'package:crc_version_1/view/login.dart';
import 'package:crc_version_1/view/no_internet.dart';
import 'package:get/get.dart';

class IntroController extends GetxController{
  List<Brands> brands = <Brands>[];
  List<Colors> colors = <Colors>[];

  @override
  void onInit() {
    super.onInit();
    get_data();
  }

  get_data(){

    Api.check_internet().then((internet) {
      if(internet){
        Api.get_data().then((data) {
          brands=data.brands;
          colors=data.colors;
          get_page();
        });
      }else{
        Get.to(()=>NoInternet())!.then((value) {
          get_data();
        });
      }
    });
  }

  get_page(){
      Store.Load_login().then((value) {
        if(Global.loginInfo!.email=="non"){
          Future.delayed(Duration(milliseconds: 1000)).then((value) {
            Get.offAll(() => LogIn());
          });
        }else{
          Api.login(Global.loginInfo!.email, Global.loginInfo!.pass).then((company_id) {
            Global.company_id=company_id;
            Future.delayed(Duration(milliseconds: 1000)).then((value) {
              Get.offAll(()=>Home());
            });
          });
        }
      });

  }

}