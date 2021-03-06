import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/setting_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/helper/store.dart';
import 'package:crc_version_1/view/add_car.dart';
import 'package:crc_version_1/view/add_people.dart';
import 'package:crc_version_1/view/contact_to_us.dart';
import 'package:crc_version_1/view/my_car_list.dart';
import 'package:crc_version_1/view/people_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Settings extends StatelessWidget {

  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) => WillPopScope(

    onWillPop: () async{
      if(settingController.isDialOpen.value){
        settingController.isDialOpen.value = false;
        settingController.carListController.updateCarList();
        return false;
      }else{
        settingController.carListController.updateCarList();
        return true;
      }
    },
    child: Obx((){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return  Scaffold(
        floatingActionButton: Global.company_id==-1?Center():_floatButton(context),
        //floatingActionButtonLocation: Global.lang_code == 'en' ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.startFloat,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
      backgroundColor: Theme.of(context).primaryColor,
      overlayColor: Theme.of(context).backgroundColor.withOpacity(0.2),
      openCloseDial: settingController.isDialOpen,
      children: [
        SpeedDialChild(
          onTap: (){
            Get.to(()=>AddPeople());
          },
          backgroundColor: Theme.of(context).primaryColor,
          labelBackgroundColor: Theme.of(context).backgroundColor,
          child: Icon(Icons.people,color: Colors.white,),
          label:  'Add people',
         labelWidget: Global.lang_code == 'en' ? _floatButtonText('Add people',context) : null,
          labelStyle: Theme.of(context).textTheme.headline3,
        ),
        SpeedDialChild(
          onTap: (){
            Get.to(()=>AddCar());
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.directions_car,color: Colors.white,),
         labelWidget:  Global.lang_code == 'en' ? _floatButtonText('Add car',context) : null,
          labelStyle: Theme.of(context).textTheme.headline3,
          labelBackgroundColor: Theme.of(context).backgroundColor,
        ),
      ],
    );
  }

  _floatButtonText(sentence,context){
    return Container(
      width: 90,
      height: 30,
      child: Center(
        child: Text(
          sentence,
          style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
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
            Global.company_id==-1?Center(): Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: (){
                    print('show');
                    showAlertDialog(context);
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4)),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(Global.companyImage.value.replaceAll("http://127.0.0.1:3004/", Api.url))
                            )
                        ),
                      ),
                      settingController.imageLoading.value ?
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      )
                      :Text(''),
                    ],
                  )
                ),
                GestureDetector(
                  onTap: (){
                    settingController.updateImage();
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
        Global.company_id==-1?Center():GestureDetector(
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
        Global.company_id==-1?Center(): Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        Global.company_id==-1?Center():GestureDetector(
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
        Global.company_id==-1?Center():Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        GestureDetector(
          onTap: (){
            settingController.openLanguagesList.value = !settingController.openLanguagesList.value;
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          width: settingController.openLanguagesList.value ? 0 : MediaQuery.of(context).size.width * 0.8,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn,
                          child: Text(App_Localization.of(context).translate('language'),maxLines: 1, style: Theme.of(context).textTheme.bodyText1,)
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn,
                          width: settingController.openLanguagesList.value ? MediaQuery.of(context).size.width * 0.9 : 0,
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: settingController.languages.length,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                      if(Global.lang_code == 'en'){
                                        if (index == 1){
                                          settingController.languagesCheck.value = [false,true];
                                          settingController.changeLanguage(context,settingController.languages[index]["id"].toString());
                                        }
                                      }else{
                                        if (index == 0){
                                          settingController.languagesCheck.value = [true,false];
                                          settingController.changeLanguage(context,settingController.languages[index]["id"].toString());
                                        }
                                      }
                                      Future.delayed(Duration(milliseconds: 1000)).then((value){
                                        settingController.openLanguagesList.value = false;
                                      });

                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(width: 1,color: Theme.of(context).dividerColor.withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child:  Text(
                                        settingController.languages[index]["name"] ,
                                        style: settingController.languagesCheck[index]
                                            ? TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)
                                            : TextStyle(color: Theme.of(context).dividerColor,fontWeight: FontWeight.bold),
                                      ),
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: !settingController.openLanguagesList.value ? Icon(Icons.arrow_forward_ios) : Icon(Icons.close),
                ),
              ],
            )
          )
        ),
        Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.3),),
        GestureDetector(
          onTap: (){
            Get.to(()=>ContactToUs());
          },
          child: Container(
            color: Colors.transparent,
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
        ),
        /*
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
         */

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
    return Global.company_id==-1?Center():GestureDetector(
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
        child: Center(child: Text(App_Localization.of(context).translate('sign_out'), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 22))),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget closeButton = TextButton(
      child: Text(App_Localization.of(context).translate('close'),style: Theme.of(context).textTheme.headline3,),
      onPressed: () {
        Get.back();
        //print(Global.companyImage);
      },
    );

    Widget editButton = TextButton(
      child: Text(App_Localization.of(context).translate("edit"),style: Theme.of(context).textTheme.headline3,),
      onPressed: () {
        settingController.updateImage();
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).backgroundColor,
      content: Obx((){
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1,color: Theme.of(context).dividerColor.withOpacity(0.4)),
            image: DecorationImage(
                fit: BoxFit.contain,
              image: NetworkImage(Global.companyImage.value.replaceAll("http://127.0.0.1:3004/", Api.url))
            )
          ),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,

        );
      }),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        editButton,
        closeButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
