import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/model/car.dart';
import 'package:crc_version_1/model/company.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarListController extends GetxController{

  var brand="%".obs;
  var model="%".obs;
  var year="%".obs;
  var color="%".obs;
  var price="999999999999999".obs;
  var sort="ASC".obs;
  RxList<Car> myCars = <Car>[].obs;
  List<Object> myCompany = <Object>[].obs;
  RxBool loading = false.obs;
  RxBool checkFilterOpen = false.obs;
  RxBool checkSortOpen = false.obs;
  RxBool yearListOpen = false.obs;
  RxBool brandListOpen = false.obs;
  RxBool carModelListOpen = false.obs;
  RxBool colorListOpen = false.obs;
  RxList<int> yearModelList = List.filled(10, 0).obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 5000.0.obs;
 // RangeValues values = RangeValues(min.value, max.value);


  @override
  void onInit() {
    super.onInit();
    getCarsList(year.value,brand.value,model.value,color.value,price.value,sort.value);
  }

  fillYearList(){
    int year = DateTime.now().year + 1;
    for(int i = 0; i < 10; i++){
      yearModelList[i] = year;
      year --;
    }
  }

  getCarsList(String year, String brand,String model, String color, String price, String sort) async{
    Api.check_internet().then((value) async{
      if(value){
        myCars.clear();
        loading.value = true;
        await Api.filter(year, brand, model, color, price, sort).then((value){
          print('**************');
          print(value.length);
          myCars.addAll(value);
        });
        loading.value = false;
      }else{

      }
    });
  }

  update_data(){
    Api.check_internet().then((value) async{
      if(value){
        // myCars.clear();
        loading.value = true;
        print(brand.value);
        print(model.value);
        print(year.value);
        await Api.filter(year.value, brand.value, model.value, color.value, price.value, sort.value).then((value){
          print('**************');
          print(value.length);
          myCars.value=value;
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
  openBrandFilterList(){
    brandListOpen.value = !brandListOpen.value;
  }
  openCarModelFilterList(){
    carModelListOpen.value = !carModelListOpen.value;
  }
  openColorFilterList(){
    colorListOpen.value = !colorListOpen.value;
  }


}