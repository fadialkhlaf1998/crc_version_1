import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/setting_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/view/add_car.dart';
import 'package:crc_version_1/view/add_people.dart';
import 'package:crc_version_1/view/my_car_list.dart';
import 'package:crc_version_1/view/people_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Settings extends StatelessWidget {

  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async{
      if(settingController.isDialOpen.value){
        settingController.isDialOpen.value = false;
        return false;
      }else{
        return true;
      }
    },
    child: Obx((){
      return  Scaffold(
        floatingActionButton: _floatButton(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _body(context),
              _footer(context),
              const SizedBox(height: 1),
            ],
          ),
        ),
      );
    }),
  );

  _floatButton(context){
    return  SpeedDial(
      spaceBetweenChildren: 10,
      closeManually: false,
      activeIcon: Icons.close,
      icon: Icons.add,
      overlayColor: Theme.of(context).dividerColor,
      backgroundColor: Theme.of(context).primaryColor,
      openCloseDial: settingController.isDialOpen,
      children: [
        SpeedDialChild(
          onTap: (){
            Get.to(()=>AddPeople());
          },
          backgroundColor: Theme.of(context).primaryColor,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          child: Icon(Icons.people,color: Colors.white,),
          label: 'Add people',
          labelStyle: Theme.of(context).textTheme.headline3,
        ),
        SpeedDialChild(
          onTap: (){
            Get.to(()=>AddCar());
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.directions_car,color: Colors.white,),
          label: 'Add car',
          labelStyle: Theme.of(context).textTheme.headline3,
          labelBackgroundColor: Theme.of(context).backgroundColor,
        ),
      ],
    );
  }
  _header(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 80,
            child: IconButton(
              onPressed: (){
                settingController.goToCarList();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: MyTheme.isDarkTheme.value ? const AssetImage('assets/images/logo_dark.png') : const AssetImage('assets/images/logo_light.png'),
                  )
              ),

            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: MediaQuery.of(context).size.width * 0.22,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4)),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(Global.companyImage)
                      )
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    settingController.changeCompanyImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit,color: Colors.white,size: 18),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10),
            Text(Global.companyTitle, style: Theme.of(context).textTheme.headline3,)
          ],
        ),
        SizedBox(width: 80),
      ],
    );
  }
  _body(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Get.to(()=> MyCarList());
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate('car_list'), style: Theme.of(context).textTheme.bodyText1,),
                const Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        GestureDetector(
          onTap: (){
            Get.to(()=>PeopleList());
          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(App_Localization.of(context).translate('people_list'), style: Theme.of(context).textTheme.bodyText1,),
                const Icon(Icons.arrow_forward_ios, size: 20),
              ],
            ),
          ),
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 45,
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
          height: 45,
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
          height: 45,
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
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTheme.isDarkTheme.value ?
              Text(App_Localization.of(context).translate('light_mode'), style: Theme.of(context).textTheme.bodyText1,)
              : Text(App_Localization.of(context).translate('dark_mode'), style: Theme.of(context).textTheme.bodyText1,),
              Row(
                children: [
                  MyTheme.isDarkTheme.value ?
                  const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
                  const SizedBox(width: 10,),
                  CupertinoSwitch(
                    activeColor: Colors.grey,
                    thumbColor: Theme.of(context).dividerColor,
                    value: MyTheme.isDarkTheme.value ,
                    onChanged: (bool value) {
                      settingController.changeMode(context);
                      Store.saveTheme(!value);
                    },
                  ),
                ],
              ),
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
        settingController.logout();
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
