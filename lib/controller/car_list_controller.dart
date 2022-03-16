import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/model/car.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarListController extends GetxController{

  IntroController introController = Get.find();

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
  RxList<bool> yearModelListCheck = List.filled(10, false).obs;
  RxList<bool>? brandListCheck;
  RxList<bool>? modelListCheck;
  RxDouble? myValue;
  RxInt? minLabel;
  RxInt? maxLabel;
  RxInt? divisionsLabel;
  RxInt selectedBrand = (-1).obs;

  RxDouble? max;


  @override
  void onInit() {
    super.onInit();
    max = 5000.0.obs;
    minLabel = 0.obs;
    myValue = 2500.0.obs;
    brandListCheck = List.filled(introController.brands.length, false).obs;
    getCarsList(year.value,brand.value,model.value,color.value,price.value,sort.value);
  }

  updateCarList(){
    Future.delayed(const Duration(milliseconds: 1500),(){
      loading.value = true;
      Api.check_internet().then((value) async{
        if(value){
          myCars.clear();
          loading.value = true;
          await Api.filter('%', '%', '%', '%', '999999999999', 'ASC').then((value){
            myCars.addAll(value);
          });
          loading.value = false;
        }else{

        }
      });
    });
  }

  fillYearList(){
    int year = DateTime.now().year + 1;
    for(int i = 0; i < 10; i++){
      yearModelList[i] = year;
      year --;
    }
  }

  getCarsList(String year, String brand,String model, String color, String price, String sort) async{
    Future.delayed(const Duration(milliseconds: 1000),(){
      loading.value = true;
      Api.check_internet().then((value) async{
        if(value){
          myCars.clear();
          loading.value = true;
          await Api.filter(year, brand, model, color, price, sort).then((value){
            myCars.addAll(value);
          });
          loading.value = false;
        }else{

        }
      });
    });
  }

  update_data(){
    Api.check_internet().then((value) async{
      if(value){
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

  chooseYearFilter(index){
    for(int i = 0; i < yearModelList.length; i++){
      yearModelListCheck[i] = false;
    }
    yearModelListCheck[index] = true;
    year.value = yearModelList[index].toString();
  }

  chooseBrandFilter(index){
    selectedBrand = introController.brands[index].id.obs;
    for(int i = 0; i < brandListCheck!.length; i++){
      brandListCheck![i] = false;
    }
    brandListCheck![index] = true;
    brand.value = introController.brands[index].title;

  }

  chooseModelFilter(index){
    modelListCheck = List.filled(introController.brands[selectedBrand.value].models.length, false).obs;

    for(int i = 0; i < modelListCheck!.length; i++){
      modelListCheck![index] = false;
    }
    modelListCheck![index] = true;
    model.value = introController.brands[selectedBrand.value].models[index].title;
  }

  clearFilterValue(){
    brand.value  = "%";
    model.value  = "%";
    year .value  = "%";
    color.value  = "%";
    price.value  = "99999999999";
    sort .value  = "ASC";
    brandListCheck = List.filled(introController.brands.length, false).obs;
    yearModelListCheck = List.filled(yearModelList.length, false).obs;
    yearListOpen.value = false;
    brandListOpen.value = false;
    colorListOpen.value = false;

  }


}