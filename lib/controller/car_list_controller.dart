import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/model/car.dart';
import 'package:crc_version_1/model/company.dart';
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


  @override
  void onInit() {
    super.onInit();
    print('-------------------');
    print(brand.value);
    print(model.value);
    print('-------------------');
    getCarsList(year.value,brand.value,model.value,color.value,price.value,sort.value);
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



}