

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

  getInfo(companyId) async {
      loading.value = true;
      await Api.check_internet().then((internet) async{
        if(internet){
          myPeopleList.clear();
          loading.value = true;
          await Api.getPeopleList(companyId).then((value){
            myPeopleList.addAll(value);
          });
          loading.value = false;
        }else{

        }
      });
  }

  deletePersonFromTheList(index){
    int id = myPeopleList[index].id;
    loading.value = true;
    Api.check_internet().then((internet){
      if(internet){
        Api.deletePerson(id).then((value){
          if(value){
            loading.value = false;
            myPeopleList.removeAt(index);
          }else{
            loading.value = false;
          }
        });
      }else{
        print('No internet');
        loading.value = false;
      }
    });
  }

}