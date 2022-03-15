

import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/model/person.dart';
import 'package:get/get.dart';

class PeopleListController extends GetxController{

  RxList<Person> myPeopleList = <Person>[].obs;
  int companyId = -1;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    companyId = Global.company_id;
    getInfo(companyId);
  }

  getInfo(companyId){
    Api.check_internet().then((internet){
      if(internet){
        Api.getPeopleList(companyId).then((value){
          myPeopleList.addAll(value);
        });
      }else{

      }
    });
  }

}