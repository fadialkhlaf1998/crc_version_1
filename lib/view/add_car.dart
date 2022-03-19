import 'dart:io';

import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/add_car_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddCar extends StatelessWidget {

  AddCarController addCarController = Get.put(AddCarController());
  final formGlobalKey = GlobalKey<FormState>();
  IntroController introController = Get.find();
  ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: _header(context),
                  ),
                  Expanded(
                    flex: 3,
                    child: _body(context),
                  ),
                ],
              ),
              addCarController.loadingUpload.value
                  ? WillPopScope(
                onWillPop: ()async => false,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Theme.of(context).dividerColor.withOpacity(0.9),
                              child: _loading(context),
                            ),
                            Text('Saving your car information',
                                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Theme.of(context).backgroundColor)),
                          ],
                        )
                  ) : Text(''),
            ],
          ),
        ),
      );
    });
  }

  _header(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.22,
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
                    addCarController.currentStep.value == 0
                        ? Get.back()
                        : addCarController.backwardStep();
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
                      image: MyTheme.isDarkTheme.value ? const AssetImage(
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
            child: SvgPicture.asset('assets/icons/add_brand.svg',color: Theme.of(context).backgroundColor,width: 30,height: 30,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 1 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 1 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_model.svg',color: Theme.of(context).backgroundColor,width: 35,height: 35,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 2 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 2 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_year.svg',color: Theme.of(context).backgroundColor,width: 35,height: 35,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 3 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 3 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_color.svg',color: Theme.of(context).backgroundColor,width: 35,height: 35,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 4 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 4 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_location.svg',color: Theme.of(context).backgroundColor,width: 40,height: 40,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 5 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 5 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_photo.svg',color: Theme.of(context).backgroundColor,width: 30,height: 30,),
          ),
          Expanded(child: Divider(
              color: addCarController.currentStep.value < 6 ? Theme
                  .of(context)
                  .dividerColor : Theme
                  .of(context)
                  .primaryColor, indent: 1, endIndent: 1, thickness: 1),),
          CircleAvatar(
            backgroundColor: addCarController.currentStep.value < 6 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            child: SvgPicture.asset('assets/icons/add_price.svg',color: Theme.of(context).backgroundColor,width: 35,height: 35,),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  _body(context) {
    return Container(
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.22 - 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child:addCarController.currentStep.value == 0 ? _brandList(context)
                : addCarController.currentStep.value == 1 ? _modelList(context)
                : addCarController.currentStep.value == 2 ? _yearModel(context)
                : addCarController.currentStep.value == 3 ?  _color(context)
                : addCarController.currentStep.value == 4 ? _location(context) 
                : addCarController.currentStep.value == 5 ? _carImage(context)
                : _carPrice(context)
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, -3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child:   Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    onPressed: () async {
                      addCarController.forwardStep(context);
                    },
                    child: Text(
                      addCarController.currentStep.value >= 6 ? App_Localization.of(context).translate('save') : App_Localization.of(context).translate('next') ,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _brandList(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: addCarController.search,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'search',
                  prefixIcon: const Icon(Icons.search,),
                  contentPadding: const EdgeInsets.all(5),
                  hintStyle: const TextStyle(fontSize: 14),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusColor: Colors.grey.withOpacity(0.5),
                  hoverColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  introController.brands.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Obx((){
                      return  GestureDetector(
                        onTap: (){
                          addCarController.selectBrand(index);
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child:  Image.network(introController.brands[index].image),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(introController.brands[index].title,style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              addCarController.selectBrandIndex![index] ? Icon(Icons.check,color: Theme.of(context).primaryColor,) : Text(''),
                            ],
                          ),
                        ),
                      );
                    }),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 25,endIndent: 25,)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _modelList(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: addCarController.search,
                autofocus: false,

                decoration: InputDecoration(
                  hintText: 'search',
                  prefixIcon: const Icon(Icons.search,),
                  contentPadding: EdgeInsets.all(5),
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusColor: Colors.grey.withOpacity(0.5),
                  hoverColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  introController.brands[addCarController.brandIndex.value].models.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Obx((){
                      return  GestureDetector(
                        onTap: (){
                          addCarController.selectModel(index);
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(introController.brands[addCarController.brandIndex.value].models[index].title,style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              addCarController.selectModelIndex![index] ? Icon(Icons.check,color: Theme.of(context).primaryColor,) : Text(''),
                            ],
                          ),
                        ),
                      );
                    }),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 25,endIndent: 25,height: 25,)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _yearModel(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: addCarController.search,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'search',
                  prefixIcon: const Icon(Icons.search,),
                  contentPadding: EdgeInsets.all(5),
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusColor: Colors.grey.withOpacity(0.5),
                  hoverColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  10,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Obx((){
                      return  GestureDetector(
                        onTap: (){
                          addCarController.selectYear(index);
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(addCarController.yearModelList[index].toString(),style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              addCarController.selectYearIndex![index] ? Icon(Icons.check,color: Theme.of(context).primaryColor,) : Text(''),
                            ],
                          ),
                        ),
                      );
                    }),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 25,endIndent: 25,height: 30,)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _color(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: addCarController.search,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'search',
                  prefixIcon: const Icon(Icons.search,),
                  contentPadding: EdgeInsets.all(5),
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusColor: Colors.grey.withOpacity(0.5),
                  hoverColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  introController.colors.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Obx((){
                      return  GestureDetector(
                        onTap: (){
                          addCarController.selectColor(index);
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(introController.colors[index].title,style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              addCarController.selectColorIndex![index] ? Icon(Icons.check,color: Theme.of(context).primaryColor,) : Text(''),
                            ],
                          ),
                        ),
                      );
                    }),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 25,endIndent: 25,height: 30,)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _location(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  addCarController.emirates.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Obx((){
                      return  GestureDetector(
                        onTap: (){
                          addCarController.selectEmirates(index);
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: addCarController.selectEmiratesIndex![index] ? Theme.of(context).primaryColor.withOpacity(0.2) :Colors.grey.withOpacity(0.1) ,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    width:  MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:AssetImage('assets/emirates/${addCarController.emiratesPhoto[index]}'),
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(addCarController.emirates[index],style: Theme.of(context).textTheme.bodyText1,),
                                ],
                              ),
                              addCarController.selectEmiratesIndex![index] ?
                              Padding(
                                padding: EdgeInsets.only(right: 10,left: 10),
                                child: Icon(Icons.check,color: Theme.of(context).primaryColor,),
                              ) : Text(''),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20,),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _carImage(context){
    
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: addCarController.imageList.length,
              itemBuilder: (context, int index){
                return Column(
                  children: [
                   Container(
                     width: MediaQuery.of(context).size.width* 0.9,
                     child:  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           width: MediaQuery.of(context).size.width * 0.4,
                           height: MediaQuery.of(context).size.height * 0.12,
                           decoration: BoxDecoration(
                             color: Theme.of(context).primaryColor,
                             borderRadius: BorderRadius.circular(10),
                             image: DecorationImage(
                               fit: BoxFit.cover,
                               image: FileImage(File(addCarController.imageList[index].path)),
                             )
                           ),
                         ),
                         IconButton(
                           onPressed: (){
                             addCarController.deleteImageFromList(index);
                           },
                           icon: Icon(Icons.delete),
                         ),
                       ],
                     ),
                   ),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 25,endIndent: 25,)
                  ],
                );
              },
            ),
            GestureDetector(
                onTap: () async{
                  if(addCarController.imageList.length == 10){
                    App.info_msg(context, 'You can upload just 10 photos');
                  }else{
                    addCarController.selectImage();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child:  Icon(Icons.add, color: Colors.white,),
                )
            ),
          ],
        ),
      ),
    );
  }

  _carPrice(context){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: formGlobalKey,
        child: Column(
          children: [
            Text(App_Localization.of(context).translate('choose_the_rent_per_day'),style: Theme.of(context).textTheme.headline2,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 80,
              child: TextFormField(
                style: Theme.of(context).textTheme.headline3,
                controller: addCarController.carPrice,
                validator: (price) {
                  if (price!.isEmpty) {
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
                  labelText: App_Localization.of(context).translate('price'),
                  hintText: App_Localization.of(context).translate('enter_the_price_you_went'),
                  hintStyle: Theme.of(context).textTheme.headline4,
                  suffixText: App_Localization.of(context).translate('aed'),
                  suffixStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );

  }

  _loading(context){
    return Container(
      child: Lottie.asset('assets/images/data.json'),
    );
  }

}