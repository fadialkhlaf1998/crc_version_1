import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:crc_version_1/model/car.dart';
import 'package:crc_version_1/model/company.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:crc_version_1/model/my_car.dart';
import 'package:crc_version_1/model/person.dart';
import 'package:crc_version_1/model/person_for_company.dart';
import 'package:http/http.dart' as http;

class Api {

  static String url = "http://phpstack-548447-2482384.cloudwaysapps.com/";

  static Future<bool> check_internet()async{
    // return false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }else{
      return false;
    }

  }

  static Future<Intro> get_data()async{
   
    var request = http.Request('GET', Uri.parse(url+'api/start_up'));
    
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsondata = await response.stream.bytesToString();
      return Intro.fromJson(jsonDecode(jsondata));
    }
    else {
    print(response.reasonPhrase);
    return Intro(brands: <Brands>[], colors: <Colors>[]);
    }

  }

  static Future<int> login(String username,String password)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/login_company'));
    request.body = json.encode({
      "username": username,
      "pass": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsondata = await response.stream.bytesToString();
      var data = jsonDecode(jsondata) as List;
      return Company.fromMap(data[0]).id;
    }
    else {
      return -1;
    }
  }

  static Future<bool> update_person(int avilable , int company_id , int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'api/contact_person_avilable'));
    request.body = json.encode({
      "avilable": avilable,
      "id": id,
      "company_id": company_id,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsondata = await response.stream.bytesToString();
      return true;
    }
    else {
      return false;
    }
  }

  static Future<List<Car>> filter(String year,String brand, String model, String color, String price, String sort ) async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/car_filter'));
    request.body = json.encode({
      "year": year,
      "brand": brand,
      "model": model,
      "color": color,
      "price": price,
      "sort": sort
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      var list = jsonDecode(jsondata) as List;
      List<Car> cars = <Car>[];
      for(var c in list){
        cars.add(Car.fromMap(c));
      }
      return cars;
    }
    else {
     return <Car>[];
    }

  }

  static Future addPerson(String name,File image, String phone, String languages, double companyId)async{

    var request = http.MultipartRequest('POST', Uri.parse(url + 'api/contact_person'));
    request.fields.addAll({
      'name': name,
      'phone': phone,
      'languages': languages,
      'company_id': companyId.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('file',image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
    }
    else {
      print('Error');
    }

  }

  static Future addCar(String brand,String brandId, String model,String modelId,String year, String color,String location, List<File> images, String price,double companyId) async{
    var request = http.MultipartRequest('POST', Uri.parse(url + 'api/car'));
    request.fields.addAll({
      'title': brand + ' - ' + model,
      'search': brand + ' - ' + model,
      'avilable': '1',
      'company_id': companyId.toString(),
      'brand_id': brandId,
      'pric_per_day': price,
      'doors': '4',
      'passengers': '4',
      'location': location,
      'color': color,
      'model_id': modelId,
      'year': year
    });

    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('files', images[i].path));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
    }
    else {
      print('Field');
    }

  }

  static Future<List<MyCar>> getMyCarsList(int companyId)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/car_for_company'));
    request.body = json.encode({
      "company_id": companyId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      var list = jsonDecode(jsondata) as List;
      List<MyCar> myCars = <MyCar>[];
      for(var c in list){
        myCars.add(MyCar.fromMap(c));
      }
      return myCars;
    }
    else {
      return <MyCar>[];
    }
  }

  static Future <List<Person>> getPeopleList(int companyId)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/contact_person_for_company'));
    request.body = json.encode({
      "company_id": companyId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      var list = jsonDecode(jsondata) as List;
      List<Person> personsList = <Person>[];
      for(var c in list){
        personsList.add(Person.fromMap(c));
      }
      return personsList;
    }
    else {
      return <Person>[];
    }

  }

  static Future deleteCar(int id)async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url + 'api/car'));
    request.body = json.encode({
      "id": id.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      return true;
    }
    else {
      print('Field');
      return false;
    }

  }

  static Future deletePerson(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url + 'api/contact_person'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      return true;
    }
    else {
      return false;
    }


  }

  static Future changeCarAvailability(String availability,int carId)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/update_avaliblity'));
    request.body = json.encode({
      "avilable": availability,
      "id": carId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
    }
    else {
      print('Field');
    }

  }

  static Future <List<PersonForCompany>> getCompanyContactInfo(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/contact_person_for_company'));
    request.body = json.encode({
      "company_id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      var list = jsonDecode(jsondata) as List;
      List<PersonForCompany> personsList = <PersonForCompany>[];
      for(var c in list){
        personsList.add(PersonForCompany.fromMap(c));
      }
      return personsList;
    }
    else {
      return <PersonForCompany>[];
    }

  }

  static Future<Car?> getCarInfo(int id)async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'api/car_info'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      var jsonData  = jsonDecode(data) as List;
      return Car.fromMap(jsonData[0]);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

}