import 'dart:io';

import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/add_people_controller.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPeople extends StatelessWidget {

  AddPeopleController addPeopleController = Get.put(AddPeopleController());
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  _header(context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.22,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Theme
            .of(context)
            .backgroundColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                child: IconButton(
                  onPressed: () {
                    addPeopleController.currentStep.value == 0
                        ? Get.back()
                        : addPeopleController.backwardStep();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: MyTheme.isDarkTheme ? const AssetImage(
                          'assets/images/logo_dark.png') : const AssetImage(
                          'assets/images/logo_light.png'),
                    )
                ),

              ),
              SizedBox(width: 80),
            ],
          ),
          _stepper(context),
        ],
      ),
    );
  }

  _stepper(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.person, color: Theme.of(context).backgroundColor),
          ),
          Expanded(child: Divider(
              color: addPeopleController.currentStep.value < 1 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor, indent: 5, endIndent: 5, thickness: 1),),
          CircleAvatar(
            backgroundColor: addPeopleController.currentStep.value < 1 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: Icon(Icons.image, color: Theme.of(context).backgroundColor),
          ),
          Expanded(child: Divider(
              color: addPeopleController.currentStep.value < 2 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 5, endIndent: 5, thickness: 1),),
          CircleAvatar(
            backgroundColor: addPeopleController.currentStep.value < 2 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: Icon(Icons.call, color: Theme.of(context).backgroundColor),
          ),
          Expanded(child: Divider(
              color: addPeopleController.currentStep.value < 3 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 5, endIndent: 5, thickness: 1),),
          CircleAvatar(
            backgroundColor: addPeopleController.currentStep.value < 3 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: Icon(Icons.language, color: Theme.of(context).backgroundColor,),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  _body(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: addPeopleController.currentStep.value == 0 ?
            _personName(context) : addPeopleController.currentStep.value == 1 ?
            _personPhoto(context) : addPeopleController.currentStep.value == 2 ? _personMobile(context) :  _personLanguage(context),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
              onPressed: () async {
                addPeopleController.forwardStep(context);
              },
              child: Text(
                addPeopleController.currentStep.value == 2 ? App_Localization.of(context).translate('next') : App_Localization.of(context).translate('save') ,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _personName(context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: formGlobalKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 80,
              child: TextFormField(
                style: Theme.of(context).textTheme.headline3,
                controller: addPeopleController.username,
                validator: (name) {
                  if (name!.isEmpty) {
                    return App_Localization.of(context).translate(
                        'username_cannot_be_empty');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Theme
                        .of(context)
                        .dividerColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Theme
                          .of(context)
                          .dividerColor)
                  ),
                  labelStyle: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                  labelText: App_Localization.of(context).translate(
                      'username'),
                  hintText: App_Localization.of(context).translate(
                      'enter_your_username'),
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _personMobile(context){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: formGlobalKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 80,
              child: TextFormField(
                style: Theme.of(context).textTheme.headline3,
                controller: addPeopleController.mobileNumber,
                validator: (mobile) {
                  if (mobile!.isEmpty) {
                    return App_Localization.of(context).translate(
                        'mobile_number_is_required');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor)
                  ),
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  labelText: App_Localization.of(context).translate('mobile_number'),
                  hintText: App_Localization.of(context).translate('enter_your_mobile_number'),
                  hintStyle: Theme.of(context).textTheme.headline4,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );

  }

  _personPhoto(context){
    return Obx((){
      return Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(App_Localization.of(context).translate('add_photo'), style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  addPeopleController.selectImage();
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: addPeopleController.userImage.length == 0  ?
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_add_alt_1, size: 60,color: Theme.of(context).backgroundColor,),
                  )
                      : Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(addPeopleController.userImage.first),
                        )
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  addPeopleController.userImage.clear();
                },
                icon: addPeopleController.userImage.isNotEmpty ? Icon(Icons.delete, color: Theme.of(context).dividerColor) : Text(''),
              ),
            ],
          ),
        ),
      );
    });
  }

  _personLanguage(context){
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: addPeopleController.language.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              print('1111');
              addPeopleController.selectLanguage(index);
            },
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Text(addPeopleController.language[index].toString(), style: Theme.of(context).textTheme.bodyText1,),
                      ),
                     Obx((){
                       return  Padding(
                         padding:EdgeInsets.only(right: 20, left: 20),
                         child: addPeopleController.select[index] ? Icon(Icons.check, color: Theme.of(context).primaryColor,) : Text(''),
                       );
                     }),
                    ],
                  ),
                  Divider(thickness: 1, color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 22,endIndent: 22,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick your choice'),
          titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: ()async{
                  // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  //   if(image == null) return;
                  //   final imageTemporary = File(image.path);
                  //   this.image = imageTemporary;
                  },
                  child: Column(
                    children: [
                      Icon(Icons.image,size: 50,color: Theme.of(context).primaryColor,),
                      Text('Gallery',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Icon(Icons.camera,size: 50,color: Theme.of(context).primaryColor,),
                      Text('Camera',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14),),
                    ],
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }



}
