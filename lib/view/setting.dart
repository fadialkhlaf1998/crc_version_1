import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _body(context),
            _footer(context),
          ],
        ),
      ),
    );
  }

  _header(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 80,
            child: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 45,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
              image: MyTheme.isDarkTheme ? const AssetImage('assets/images/logo_dark.png') : const AssetImage('assets/images/logo_light.png'),
            )
          ),

        ),
        SizedBox(width: 80),
      ],
    );
  }
  _body(context){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('car_list'), style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('people_list'), style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('language'), style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('connect_to_us'), style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('about') + ' CRC', style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(App_Localization.of(context).translate('light_mode'), style: Theme.of(context).textTheme.bodyText1,),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
      ],
    );
  }
  _footer(context){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(child: Text('Sign out', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 22))),
      ),
    );
  }


}
