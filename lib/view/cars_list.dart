import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/view/add_car.dart';
import 'package:crc_version_1/view/add_people.dart';
import 'package:crc_version_1/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return carListController.openContactList.value = false;
      },
      child: Scaffold(
        floatingActionButton: _floatButton(context),
        body:Obx((){
          return  SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _body(context),
                _background(context),
                _filterInterface(context),
                _sortInterface(context),
                _appBar(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _appBar(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
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
                  carListController.openContactList.value = false;
                  carListController.checkSortOpen.value = false;
                  carListController.checkFilterOpen.value = false;
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios,size: 20,),
              )
          ),
          GestureDetector(
            onTap: (){
              carListController.openContactList.value = false;
              carListController.openFiler();
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
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
          GestureDetector(
            onTap: (){
              carListController.openContactList.value = false;
              carListController.openSort();
            },
            child: Container(
              color: Colors.transparent,
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
                carListController.openContactList.value = false;
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
        duration: const Duration(milliseconds: 800),
        child: carListController.checkFilterOpen.value || carListController.checkSortOpen.value ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).dividerColor.withOpacity(0.5),
        ) : const Text(''),
      ),
    );
  }

  _body(context){
    return RefreshIndicator(
      onRefresh: ()async {
        await carListController.getCarsList(
            carListController.yearFilter.value,
            carListController.brandFilter.value,
            carListController.modelFilter.value,
            carListController.colorFilter.value,
            carListController.priceFilter.value,
          carListController.sortFilter.value
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
            child:carListController.loading.value
                ? Center(child: Container(child: Lottie.asset('assets/images/Animation.json')))
                : carListController.myCars.isEmpty
                ? Center(child: Text(App_Localization.of(context).translate('no_car')))
                : ListView.builder(
                itemCount: carListController.myCars.length,
                itemBuilder:(context, index){
                  return  Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            _companyInfo(context, index),
                            const SizedBox(height: 10),
                            _carInfo(context,index),
                            const SizedBox(height: 10),
                            _contactOptions(context,index),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, indent: 20,endIndent: 20,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 25,),
                    ],
                  );
                }
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: carListController.openContactList.value ? _showContactsList(context) : Text('')
          ),
        ],
      ),
    );
  }

  _companyInfo(context, index){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: carListController.myCars[index].companyImage == null ?
            Image.asset('assets/images/car.png')
                : Image.network(
                carListController.myCars[index].companyImage,
            ),
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
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width* 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(20),
                ),
              child:ImageSlideshow(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.2,
                initialPage: 0,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorBackgroundColor: Colors.grey,
                children:
                  carListController.myCars.value[index].images.map((e) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(Api.url+"uploads/"+ e.link),
                            fit: BoxFit.cover
                        )
                    ),
                  )).toList()
                ,
                autoPlayInterval: 0,
                isLoop: false,
              ),
            ),
            carListController.myCars[index].avilable == 0
                ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width* 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/notAvailable.png')
                          )
                      ),
                    ),

              ],
            ) : Text('')
          ],
        ),
        const SizedBox(height: 10),
        Container(
          child: Text(App_Localization.of(context).translate('daily_rent') + '  ' + carListController.myCars[index].pricPerDay.toString() + ' ' + App_Localization.of(context).translate('aed'),style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Container(
          width: MediaQuery.of(context).size.width  * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(carListController.myCars[index].brand + ' - ' + carListController.myCars[index].model, maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.headline2),],)
        ),
        Container(
          child: Text(App_Localization.of(context).translate('year') + ' : ' + carListController.myCars[index].year.toString(),style: Theme.of(context).textTheme.headline3),
        ),

        // Text(),
        // Text(),

      ],
    );
  }

  _contactOptions(context,index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx((){
            return  GestureDetector(
              onTap: () {
                if(carListController.myCars[index].avilable == 1){
                  carListController.getContactData(carListController.myCars[index].companyId);
                  carListController.bookOnWhatsappCheck = true.obs;
                  //_contactsMenu(index);
                  carListController.openContactList.value = true;
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45 - 5,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: carListController.myCars[index].avilable == 1 ?Theme.of(context).primaryColor : Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      child: Image.asset('assets/images/whatsapp.png'),
                    ),
                    const SizedBox(width: 5,),
                    Text(App_Localization.of(context).translate('book_on_whatsapp'),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            );
          }),
          const SizedBox(width: 10),
         Obx((){
           return  GestureDetector(
             onTap: (){
               if(carListController.myCars[index].avilable == 1){
                 carListController.getContactData(carListController.myCars[index].companyId);
                 carListController.bookOnWhatsappCheck = false.obs;
                 carListController.openContactList.value = true;
               }
             },
             child: AnimatedContainer(
               duration: const Duration(milliseconds: 500),
               width: MediaQuery.of(context).size.width * 0.45 - 5,
               height: 45,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color:  carListController.myCars[index].avilable == 1 ?Theme.of(context).primaryColor : Colors.grey,
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const Icon(Icons.phone,color: Colors.white,),
                   const SizedBox(width: 5),
                   Text(App_Localization.of(context).translate('call_us_to_book'),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                 ],
               ),
             ),
           );
         }),
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
                      child: carListController.brandFilter.value != '%'
                          ? Column(children: [const SizedBox(height: 10,) ,_modelFilterMenu(context),const SizedBox(height: 10,)],)
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
                            carListController.getFilterResult();
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
                                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4),width: 1)
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
              )
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
                               border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4),width: 1)
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
                           //width: 90,
                           padding: EdgeInsets.symmetric(horizontal: 10),
                           decoration: BoxDecoration(
                               color: !carListController.modelListCheck![index] == true
                                   ? Theme.of(context).backgroundColor
                               : Theme.of(context).primaryColor,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4),width: 1)
                           ),
                           child: Center(
                             child: Text(
                               introController.brands[carListController.selectedBrand.value].models[index].title,textAlign: TextAlign.center,
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   color: !carListController.modelListCheck![index] == true
                                       ? Theme.of(context).dividerColor
                                   : Theme.of(context).backgroundColor,
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
                      Obx((){
                        return GestureDetector(
                          onTap: (){
                            carListController.chooseColorFilter(index);
                          },
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: !carListController.colorListFilter![index] == true
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.4),width: 1)
                            ),
                            child: Center(
                              child: Text(
                                introController.colors[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: !carListController.colorListFilter![index] == true
                                        ? Theme.of(context).dividerColor
                                        : Theme.of(context).backgroundColor ,
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
                GestureDetector(
                  onTap: (){
                    carListController.selectSortType(0);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                      color: carListController.sortFilter.value == "ASC"
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Price Low to high',
                        style: TextStyle(
                            color: carListController.sortFilter.value == 'ASC'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    carListController.selectSortType(1);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                      color:carListController.sortFilter.value != "ASC"
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Price high to low',
                        style: TextStyle(
                            color: carListController.sortFilter.value != 'ASC'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _contactsMenu(index){
    return showModalBottomSheet(
      barrierColor: Theme.of(context).dividerColor.withOpacity(0.3),
      backgroundColor: Theme.of(context).backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
      context: context,
      builder: (context){
        return Container(
          height: 250,
          child: Obx((){
            return Stack(
              children: [
                carListController.loadingContact.value
                    ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
                    : Text(''),
                carListController.companyContactsList.isEmpty
                ? Center(
                  child: Text(
                    App_Localization.of(context).translate('there_are_no_people_at_the_moment'),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5,),
                    Text(
                      App_Localization.of(context).translate('contact_list'),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),indent: 80,endIndent: 80,height: 10,),
                    Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: carListController.companyContactsList.length,
                        itemBuilder: (context,index){
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async{

                              },
                              child: Container(
                                height: 130,
                                width: 300-20,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    )
                                  ]
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(Api.url + 'uploads/' + carListController.companyContactsList[index].image),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),),
                                    Expanded(
                                      flex: 1,
                                      child:   Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                        color: Theme.of(context).backgroundColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  carListController.companyContactsList[index].name,
                                                  style: Theme.of(context).textTheme.headline2,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              carListController.companyContactsList[index].phone,
                                              style: Theme.of(context).textTheme.headline3,
                                              maxLines: 1,
                                            ),

                                            Text(
                                              carListController.companyContactsList[index].languages,
                                              style: Theme.of(context).textTheme.headline3,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),

                                            SizedBox(width: 10),
                                            Column(
                                              children: [

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),),


                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      }
    );
  }

  _showContactsList(context){
    return GestureDetector(
      onTap: (){
        carListController.openContactList.value = false;
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0XFF202428).withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: carListController.loadingContact.value
                      ? CircularProgressIndicator()
                      : carListController.companyContactsList.isEmpty
                    ? Text('')
                      : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: carListController.companyContactsList.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: ()async{
                            if(carListController.bookOnWhatsappCheck!.value){
                              await carListController.bookOnWhatsapp(context, index);
                            }else{
                              carListController.bookOnPhone(index);
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width:  MediaQuery.of(context).size.width * 0.05),
                                      Container(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.17),
                                        width: MediaQuery.of(context).size.width * 0.60,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              carListController.companyContactsList[index].name,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.headline3,
                                            ),
                                            Text(
                                              carListController.companyContactsList[index].languages,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.headline3,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1,color: Theme.of(context).backgroundColor.withOpacity(0.3)),
                                        image: DecorationImage(
                                            image: NetworkImage(Api.url + 'uploads/' + carListController.companyContactsList[index].image),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    height: 85,
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  _floatButton(context){
    return  SpeedDial(
      spaceBetweenChildren: 10,
      closeManually: false,
      activeIcon: Icons.close,
      icon: Icons.add,
      backgroundColor: Theme.of(context).primaryColor,
      overlayColor: Theme.of(context).backgroundColor.withOpacity(0.2),
      openCloseDial: carListController.isDialOpen,
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


}


