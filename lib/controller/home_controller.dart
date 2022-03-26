import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:crc_version_1/view/cars_list.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  IntroController introController = Get.find();
  CarListController carListController = Get.put(CarListController());


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
    for(int i = 0; i < tempBrandsList.length; i++) {
      tempBrandsList[i].selected.value = false;
    }
    tempBrandsList[index].selected.value = true;
    brandName.value = tempBrandsList[index].title;
    brandIndex.value = brands.indexOf(tempBrandsList[index]);
    tempModelsList.value = brands[brands.indexOf(tempBrandsList[index])].models;
  }

  getAll(){
    print('========');
    carListController.brand = brandName;
    carListController.model = modelName;
    print('========');
    Get.to(()=>CarsList());
  }

  chooseModel(index){
    carListController.brand = brandName;
    carListController.model.value = brands[brandIndex.value].models[index].title;
    Get.to(()=>CarsList());
  }

  filterSearchResults(String query) {
    if(modelOption.value == false){
      for(int i = 0; i <  tempBrandsList.length; i++){
        tempBrandsList[i].selected.value = false;
      }
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
        print(tempBrandsList.length);

        return;
      } else {
        tempBrandsList.clear();
        tempBrandsList.addAll(brands);

      }
    }

    else if(modelOption.value == true){
      List<Models> dummySearchList = <Models>[];
      dummySearchList.addAll(brands[brandIndex.value].models);
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
        tempModelsList.clear();
        tempModelsList.addAll(brands[brandIndex.value].models);

      }
    }

  }









}