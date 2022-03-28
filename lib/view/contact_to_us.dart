import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactToUs extends StatelessWidget {
  const ContactToUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //_body(context),
            _app_bar(context),
          ],
        ),
      ),
    );
  }


  _app_bar(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 5,left: 5),
              child: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios,size: 20,),
              )
          ),
          Container(
            width: 100,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: MyTheme.isDarkTheme.value ? AssetImage('assets/images/logo_dark.png') :  AssetImage('assets/images/logo_light.png')
                )
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }


}
