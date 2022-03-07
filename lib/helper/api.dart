
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:crc_version_1/model/car.dart';
import 'package:crc_version_1/model/company.dart';
import 'package:crc_version_1/model/intro.dart';
import 'package:http/http.dart' as http;

class Api {

  static String url = "http://10.0.2.2:3000/";

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
      return Company.fromJson(data[0]).id;
    }
    else {
      return -1;
    }
  }

  static Future<List<Car>> filter(String year,String brand, String model, String color, String price, String sort ) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/car_filter'));
    request.body = json.encode({
      "year": "%",
      "brand": "%",
      "model": "%",
      "color": "%",
      "price": "999999999999999999999999999999999999999999999999999",
      "sort": "ASC"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      return List.from(jsonDecode(jsondata)).map((e)=>Car.fromJson(e)).toList();
    }
    else {
      return <Car>[];
    }

  }

  // static Future<List<Brand>> getBrands()async {
  //
  //   var request = http.Request('GET', Uri.parse(url + 'api/brand'));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if(response.statusCode == 200){
  //     var json = await response.stream.bytesToString();
  //     var list = jsonDecode(json) as List;
  //     List<Brand> brands = <Brand>[];
  //     for(var l in list){
  //       brands.add(Brand.fromMap(l));
  //     }
  //     return brands;
  //   }
  //   else {
  //     return [];
  //   }
  // }



}