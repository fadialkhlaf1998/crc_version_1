

import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/model/person_for_company.dart';
import 'package:get/get.dart';

class PeopleListController extends GetxController{

  RxList<PersonForCompany> myPeopleList = <PersonForCompany>[].obs;
  int companyId = -1;
  RxBool loading = false.obs;
  RxInt? currentIndex ;

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

  changeAvailability(index){
    print('1234567');
    int personId = myPeopleList[index].id;
    if(myPeopleList[index].availableSwitch.value == true){
      myPeopleList[index].availableSwitch.value = false;
      Api.changePersonAvailability(0, Global.company_id ,personId).then((value){
        if(value){
          print('Success');
        }
      });
    }else if(myPeopleList[index].availableSwitch.value == false){
      myPeopleList[index].availableSwitch.value = true;
      Api.changePersonAvailability(1, Global.company_id ,personId);
    }

  }

}