import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroView extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(),
                  _carImage(),
                  _title(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Global.lang_code == 'en'
              ? Container(child: MyTheme.isDarkTheme.value ?  Image.asset('assets/images/logo_dark.png') : Image.asset('assets/images/logo_light.png'), )
              : Image.asset('assets/images/lines.png', fit: BoxFit.cover,),
        ),
        Expanded(
          flex: 1,
          child: Global.lang_code == 'en'
              ? Image.asset('assets/images/lines.png', fit: BoxFit.cover,)
              : Container(child: MyTheme.isDarkTheme.value ?  Image.asset('assets/images/logo_dark.png') : Image.asset('assets/images/logo_light.png'), )
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
     // height: MediaQuery.of(context).size.height * 0.45-MediaQuery.of(context).padding.top,
    child: Row(
        children: [
          Global.lang_code == 'en'
              ? Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset('assets/images/english_title.png',fit: BoxFit.contain,),
            ),
          )
              :  Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
                child: MyTheme.isDarkTheme.value ?  Image.asset('assets/images/arabic_title_light.png' ): Image.asset('assets/images/arabic_title.png'),
            ),
          ),
          Global.lang_code == 'en'
              ? Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: MyTheme.isDarkTheme.value ?  Image.asset('assets/images/arabic_title_light.png' ): Image.asset('assets/images/arabic_title.png'),            ),
          )
              :  Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset('assets/images/english_title.png',fit: BoxFit.contain,),
            ),
          ),
        ],
      ),
    );
  }

}
