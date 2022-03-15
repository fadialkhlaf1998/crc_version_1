
import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/my_car_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class MyCarList extends StatelessWidget {

  MyCarListController myCarListController = Get.put(MyCarListController());


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
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
        ),
      );
    });
  }


  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child:myCarListController.loading.value?Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
      ): SingleChildScrollView(
        child: Column(
          children: [
            SizedBox( height: MediaQuery.of(context).size.height * 0.02),
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: myCarListController.myCarList.length,
                itemBuilder:(context, index){
                  return  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: [
                            _carImage(context, index),
                            SizedBox(width: 5),
                            _carDetails(context,index),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, indent: 25,endIndent: 25,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 40,),
                    ],
                  );
                }
            ),
          ],
        ),
      ),
    );
  }

  _carImage(context,index){
    return Expanded(
      flex: 2,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                //  image: NetworkImage(myCarListController.myCarList[index].image),
                  image: AssetImage('assets/emirates/Ajman.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55),
                    BlendMode.darken,
                  ),
                )
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Theme.of(context).backgroundColor,size: 20),
                        SizedBox(width: 3),
                        Text('Edit', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Theme.of(context).backgroundColor,size: 20),
                        SizedBox(width: 3),
                        Text('Delete', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _carDetails(context,index){
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              myCarListController.myCarList[index].brand
                  + ' - ' + myCarListController.myCarList[index].model,
              maxLines: 2,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              App_Localization.of(context).translate('daily_rent') + ' ' + myCarListController.myCarList[index].pricPerDay.toString()
              + ' ' + App_Localization.of(context).translate('aed'),
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15 ),
            ),
            Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.1),indent: 1,endIndent: 10,height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(App_Localization.of(context).translate('hid_or_show'),style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 12, fontWeight: FontWeight.bold )),
               Container(
                 height: 0,
                 width: MediaQuery.of(context).size.width * 0.1,
                 child: Transform.scale(
                   scale: 0.85,
                     child: Switch(
                     activeColor: Theme.of(context).primaryColor,
                     value: false,// myCarListController.myCarList[index].avilable,
                     onChanged: (bool value) {
                       myCarListController.changeAvailability(index);
                     },
                   ),
                 ),
               )
              ],
            ),
          ],
        )
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
                  myCarListController.checkSortOpen.value = false;
                  myCarListController.checkFilterOpen.value = false;
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios,size: 20,),
              )
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                myCarListController.openFiler();
              },
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset('assets/images/filter.svg',
                      color: myCarListController.checkFilterOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    App_Localization.of(context).translate('filter'),
                    style: TextStyle(
                        color: myCarListController.checkFilterOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
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
                myCarListController.openSort();
              },
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    child: SvgPicture.asset('assets/images/sort.svg',
                        color: myCarListController.checkSortOpen.value ? Theme.of(context).primaryColor : Theme.of(context).dividerColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    App_Localization.of(context).translate('sort'),
                    style: TextStyle(
                      color: myCarListController.checkSortOpen.value ?
                      Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
         const SizedBox(width: 40),
        ],
      ),
    );
  }
  _filterInterface(context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: myCarListController.checkFilterOpen.value ? MediaQuery.of(context).size.height  * 0.6 : 10,
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
            SizedBox(height: MediaQuery.of(context).size.height  * 0.08,),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              color: Colors.red,
              width: MediaQuery.of(context).size.width * 0.9,
              height: myCarListController.yearListOpen.value ? MediaQuery.of(context).size.height * 0.2 : 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: (){
                        myCarListController.openYearFilterList();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Year', style: Theme.of(context).textTheme.headline2,),
                            myCarListController.yearListOpen.value ?  Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                      )
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _sortInterface(context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: myCarListController.checkSortOpen.value ? MediaQuery.of(context).size.height  * 0.25 : 10,
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
  _background(context){
    return GestureDetector(
      onTap: (){
        myCarListController.checkSortOpen.value = false;
        myCarListController.checkFilterOpen.value = false;
      },
      child:  AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: myCarListController.checkFilterOpen.value || myCarListController.checkSortOpen.value ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).dividerColor.withOpacity(0.7),
        ) : Text(''),
      ),
    );
  }



}

