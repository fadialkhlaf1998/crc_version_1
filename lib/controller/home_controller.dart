import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:crc_version_1/view/cars_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  IntroController introController = Get.find();
  CarListController carListController = Get.put(CarListController());
  TextEditingController editingController = TextEditingController();



  RxList<Brands> brands = <Brands>[].obs;
  RxList<Colors> colors = <Colors>[].obs;
  RxList<Brands> tempBrandsList = <Brands>[].obs;
  RxList<Models> tempModelsList = <Models>[].obs;

  RxBool modelOption = false.obs;
  RxInt modelsLength = 0.obs;
  RxInt brandIndex = 0.obs;
  RxString brandName = '%'.obs;
  RxString modelName = '%'.obs;
  RxInt? brandId;

  @override
  void onInit() {
    super.onInit();
    get_data();
  }
  get_data(){
    brands=introController.brands.obs;
    tempBrandsList.addAll(brands);
    colors=introController.colors.obs;
  }

  chooseBrand(index){
    // for(int i = 0; i < tempBrandsList.length; i++) {
    //   tempBrandsList[i].selected.value = false;
    // }
    // tempBrandsList[index].selected.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    brandName.value = tempBrandsList[index].title;
    brandIndex.value = brands.indexOf(tempBrandsList[index]);
    tempModelsList = brands[brands.indexOf(tempBrandsList[index])].models.obs;
    modelOption.value = true;
  }

  getAll(){
    FocusManager.instance.primaryFocus?.unfocus();
    brandName.value= "%";
    modelName.value= "%";
    tempBrandsList[brandIndex.value].selected.value = false;
     carListController.brand = brandName;
     carListController.model = modelName;
    Get.to(()=>CarsList());
  }

  getAllModels(){
    FocusManager.instance.primaryFocus?.unfocus();
    modelName.value= "%";
    carListController.brand = brandName;
    carListController.model = modelName;
    Get.to(()=>CarsList());
  }

  goToBrandMenu(){
    FocusManager.instance.primaryFocus?.unfocus();

    modelOption.value = false;
    tempBrandsList[brandIndex.value].selected.value = false;
    editingController.text = '';
  }

  chooseModel(index){
    FocusManager.instance.primaryFocus?.unfocus();
    carListController.brand = brandName;
    carListController.model.value = brands[brandIndex.value].models[index].title;
    Get.to(()=>CarsList());
  }

  filterSearchResults(String query) {
    if(modelOption.value == false){
      List<Brands> dummySearchList = <Brands>[];
      dummySearchList.addAll(brands);
      if(query.isNotEmpty) {
        List<Brands> dummyListData = <Brands>[];
        for (var brand in dummySearchList) {
          if(brand.title.toLowerCase().contains(query)) {
            dummyListData.add(brand);
          }
        }
        tempBrandsList.clear();
        tempBrandsList.addAll(dummyListData);
        return;
      } else {
        tempBrandsList.clear();
        tempBrandsList.addAll(brands);

      }
    }
    else if(modelOption.value == true){
      List<Models> dummySearchList = <Models>[];
      dummySearchList.addAll(brands[brandIndex.value].models);
      print('///////////');
      print(brands[brandIndex.value].models.length);
      if(query.isNotEmpty) {
        List<Models> dummyListData = <Models>[];
        for (var model in dummySearchList) {
          if(model.title.toLowerCase().contains(query)) {
            dummyListData.add(model);
          }
        }
        tempModelsList.clear();
        tempModelsList.addAll(dummyListData);
        return;
      } else {
        print('empty');
        print(brands[brandIndex.value].models.length);
        tempModelsList.clear();
        tempModelsList.addAll(brands[brandIndex.value].models);

      }
    }

  }









}