import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/view/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CarsList extends StatefulWidget {

  CarListController carListController = Get.find();
  IntroController introController = Get.find();

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {

  CarListController carListController = Get.find();
  IntroController introController = Get.find();

  _CarsListState(){
    carListController.update_data();
    carListController.fillYearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx((){
        return  SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _body(context),
              _background(context),
              _filterInterface(context),
              _sortInterface(context),
              _app_bar(context),
            ],
          ),
        );
      }),
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
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 6), // changes position of shadow
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
                  carListController.checkSortOpen.value = false;
                  carListController.checkFilterOpen.value = false;
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios,size: 20,),
              )
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                carListController.openFiler();
              },
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset('assets/images/filter.svg',
                      color: carListController.checkFilterOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                      App_Localization.of(context).translate('filter'),
                      style: TextStyle(
                        color: carListController.checkFilterOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            indent: 20,
            endIndent: 20,
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                carListController.openSort();
              },
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    child: SvgPicture.asset('assets/images/sort.svg',
                      color: carListController.checkSortOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                      App_Localization.of(context).translate('sort'),
                      style: TextStyle(
                          color: carListController.checkSortOpen.value ?
                          Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15,left: 15),
            child: IconButton(
              onPressed: (){
                carListController.checkSortOpen.value = false;
                carListController.checkFilterOpen.value = false;
                Get.to(()=>Settings());
              },
              icon: const Icon(Icons.menu),
            ),
          )
        ],
      ),
    );
  }

  _background(context){
    return GestureDetector(
      onTap: (){
        carListController.checkSortOpen.value = false;
        carListController.checkFilterOpen.value = false;
      },
      child:  AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: carListController.checkFilterOpen.value || carListController.checkSortOpen.value ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).dividerColor.withOpacity(0.7),
        ) : Text(''),
      ),
    );
  }

  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child:carListController.loading.value
          ? Center(child: Container(child: Lottie.asset('assets/images/Animation.json')))
          : carListController.myCars.isEmpty
          ? Center(child: Text('No car'),)
          : ListView.builder(
          itemCount: carListController.myCars.length,
          itemBuilder:(context, index){
            return  Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.44,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _companyInfo(context, index),
                      const SizedBox(height: 10),
                      _carInfo(context,index),
                      const SizedBox(height: 10),
                      _contentOption(context),
                    ],
                  ),
                ),
                Divider(thickness: 1, indent: 30,endIndent: 30,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 40,),
              ],
            );
          }
      ),
    );
  }

  _companyInfo(context, index){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 20,
            child: carListController.myCars[index].companyImage == null ?
            Image.asset('assets/images/car.png') : Image.network(carListController.myCars[index].companyImage),
          ),
          const SizedBox(width: 10),
          Text(carListController.myCars[index].company,style: Theme.of(context).textTheme.headline3,),
        ],
      ),
    );
  }

  _carInfo(context,index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width* 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  Api.url + 'uploads/' + carListController.myCars[index].image,
              )
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          child: Text(App_Localization.of(context).translate('daily_rent') + '  ' + carListController.myCars[index].pricPerDay.toString() + ' ' + App_Localization.of(context).translate('aed'),style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Container(
          child: Text(carListController.myCars[index].brand + ' - ' + carListController.myCars[index].model,style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          child: Text(App_Localization.of(context).translate('year') + ' : ' + carListController.myCars[index].year.toString(),style: Theme.of(context).textTheme.headline3),
        ),

        // Text(),
        // Text(),

      ],
    );
  }

  _contentOption(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width * 0.43,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.whatsapp,color: Colors.white,),
                Text('Book on whatsApp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          const SizedBox(width: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width * 0.43,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.phone,color: Colors.white,),
                Text('Call us to book',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _filterInterface(context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: carListController.checkFilterOpen.value ? MediaQuery.of(context).size.height  * 0.6 : 10,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      child: SingleChildScrollView(
        child: Column(
          //alignment: Alignment.bottomCenter,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              height: carListController.checkFilterOpen.value ? MediaQuery.of(context).size.height  * 0.52 : 10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height  * 0.1,),
                    _yearFilterMenu(context),
                    const SizedBox(height: 10,),
                    _brandFilterMenu(context),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: carListController.brand.value != '%'
                          ? _modelFilterMenu(context)
                          : Text('')
                    ),
                    _colorFilterMenu(context),
                    const SizedBox(height: 10,),
                    _priceFilterMenu(context),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: carListController.checkFilterOpen.value ? MediaQuery.of(context).size.height  * 0.08 : 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            App_Localization.of(context).translate('done'),
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: (){
                          carListController.clearFilterValue();
                        },
                        icon: Icon(Icons.delete_outline),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  _yearFilterMenu(context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: MediaQuery.of(context).size.width * 0.9,
      height: carListController.yearListOpen.value ? MediaQuery.of(context).size.height * 0.11 : 30,
      child: SingleChildScrollView(
        physics: !carListController.yearListOpen.value ? const NeverScrollableScrollPhysics() :null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  carListController.openYearFilterList();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(App_Localization.of(context).translate('year'), style: Theme.of(context).textTheme.headline2,),
                      carListController.yearListOpen.value ?  Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                )
            ),
            const SizedBox(height: 15),
            Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: carListController.yearModelList.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                      Obx((){
                        return  GestureDetector(
                          onTap: (){
                            carListController.chooseYearFilter(index);
                          },
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                                color: !carListController.yearModelListCheck[index] == true
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Theme.of(context).dividerColor,width: 1)
                            ),
                            child: Center(
                              child:  Text(
                                carListController.yearModelList[index].toString(),
                                style: TextStyle(
                                    color: carListController.yearModelListCheck[index] == true
                                        ? Colors.white
                                        : Theme.of(context).dividerColor
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(width: 10,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _brandFilterMenu(context){
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: MediaQuery.of(context).size.width * 0.9,
      height: carListController.brandListOpen.value ? MediaQuery.of(context).size.height * 0.11 : 30,
      child: SingleChildScrollView(
        physics: !carListController.brandListOpen.value ? const NeverScrollableScrollPhysics() : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  carListController.openBrandFilterList();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(App_Localization.of(context).translate('brand'), style: Theme.of(context).textTheme.headline2,maxLines: 2,),
                      carListController.brandListOpen.value ?  Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                )
            ),
            const SizedBox(height: 15),
            Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: introController.brands.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                     Obx((){
                       return  GestureDetector(
                         onTap: (){
                           carListController.chooseBrandFilter(index);
                         },
                         child: Container(
                           width: 80,
                           decoration: BoxDecoration(
                               color: !carListController.brandListCheck![index] == true
                                   ? Theme.of(context).backgroundColor
                                   : Theme.of(context).primaryColor,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(color: Theme.of(context).dividerColor,width: 1)
                           ),
                           child: Center(
                             child: Text(
                               introController.brands[index].title,textAlign: TextAlign.center,
                               style: TextStyle(
                                   color: !carListController.brandListCheck![index] == true
                                       ? Theme.of(context).dividerColor
                                       : Colors.white,
                                   fontSize: 11,fontWeight: FontWeight.bold),),
                           ),
                         ),
                       );
                     }),
                      SizedBox(width: 8,),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _modelFilterMenu(context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: MediaQuery.of(context).size.width * 0.9,
      height: carListController.carModelListOpen.value ? MediaQuery.of(context).size.height * 0.11 : 30,
      child: SingleChildScrollView(
        physics: !carListController.carModelListOpen.value ? const NeverScrollableScrollPhysics() :null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  carListController.openCarModelFilterList();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(App_Localization.of(context).translate('car_model'), style: Theme.of(context).textTheme.headline2,),
                      ),
                      carListController.carModelListOpen.value ?  Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                )
            ),
            const SizedBox(height: 15),
            Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: introController.brands[carListController.selectedBrand.value].models.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                     Obx((){
                       return  GestureDetector(
                         onTap: (){
                           carListController.chooseModelFilter(index);
                         },
                         child: Container(
                           width: 90,
                           decoration: BoxDecoration(
                               color: Theme.of(context).backgroundColor,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(color: Theme.of(context).dividerColor,width: 1)
                           ),
                           child: Center(
                             child: Text(
                               introController.brands[carListController.selectedBrand.value].models[index].title,textAlign: TextAlign.center,
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   color: Theme.of(context).dividerColor,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold),),
                           ),
                         ),
                       );
                     }),
                      SizedBox(width: 8,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _colorFilterMenu(context){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: MediaQuery.of(context).size.width * 0.9,
      height: carListController.colorListOpen.value ? MediaQuery.of(context).size.height * 0.11 : 30,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  carListController.openColorFilterList();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(App_Localization.of(context).translate('color'), style: Theme.of(context).textTheme.headline2,),
                      carListController.colorListOpen.value ?  Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                )
            ),
            const SizedBox(height: 15),
            Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: introController.colors.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Theme.of(context).dividerColor,width: 1)
                        ),
                        child: Center(
                          child: Text(introController.colors[index].title,textAlign: TextAlign.center,style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 12,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(width: 8,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _priceFilterMenu(context){
    return Obx((){
      return Container(
        child: Row(
          children: [
            const SizedBox(width: 15,),
            Container(
              child: Text('0',style: Theme.of(context).textTheme.headline3,),
            ),
            Expanded(
              child: Slider(
                value: carListController.myValue!.value,
                min: 0,
                max: carListController.max!.value,
                divisions: 50,
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                label: carListController.myValue!.value.round().toString() + ' AED',
                onChanged: (value){
                  setState(() {
                    carListController.myValue!.value = value;
                  });
                },
              ),
            ),
            Container(
              child: Text(carListController.max!.value.round().toString() + ' AED',style: Theme.of(context).textTheme.headline3,),
            ),
            const SizedBox(width: 15,),
          ],
        )
      );
    });
  }

  _sortInterface(context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: carListController.checkSortOpen.value ? MediaQuery.of(context).size.height  * 0.25 : 10,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height  * 0.1,),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Price Low to high', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Price high to low', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


