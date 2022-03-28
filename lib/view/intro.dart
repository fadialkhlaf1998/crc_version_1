import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroView extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage('assets/images/background2_light.png')
        //   )
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _header(),
            _carImage(),
            _title(context),
          ],
        ),
      ),
    );
  }

  _header(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: MyTheme.isDarkTheme.value ?  Image.asset('assets/images/logo_dark.png') : Image.asset('assets/images/logo_light.png'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Image.asset('assets/images/lines.png', fit: BoxFit.cover,),
          ),
        ),

      ],
    );
  }
  _carImage(){
    return Container(
      child: Image.asset('assets/images/car.png'),
    );
  }
  _title(context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
    child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset('assets/images/english_title.png',fit: BoxFit.contain,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset('assets/images/arabic_title.png'),
            ),
          ),
        ],
      ),
    );
  }

}
