

import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:get/get.dart';
import 'package:crc_version_1/model/my_car.dart';

class MyCarListController extends GetxController{


  RxBool checkFilterOpen = false.obs;
  RxBool checkSortOpen = false.obs;
  RxBool yearListOpen = false.obs;
  int companyId = -1;
  RxList<MyCar> myCarList = <MyCar>[].obs;
  RxBool loading = false.obs;


  @override
  void onInit() {
    super.onInit();
    companyId = Global.company_id;
    getCarList(companyId);

  }

  getCarList(int companyId){
    myCarList.clear();
    Api.check_internet().then((internet)async{
      if(internet){
        loading.value = true;
        Api.getMyCarsList(companyId).then((value)async{
          myCarList.addAll(value);
        });
        loading.value = false;
      }else{

      }
    });
  }
  openFiler(){
    checkFilterOpen.value = !checkFilterOpen.value;
    if(checkSortOpen.value == true){
      checkSortOpen.value = false;
    }
  }
  openSort(){
    checkSortOpen.value = !checkSortOpen.value;
    if(checkFilterOpen.value == true){
      checkFilterOpen.value = false;
    }
  }
  openYearFilterList(){
    yearListOpen.value = !yearListOpen.value;
  }

  changeAvailability(index){

  }


}