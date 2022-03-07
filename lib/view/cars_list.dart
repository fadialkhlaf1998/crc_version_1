import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/car_list_controller.dart';
import 'package:crc_version_1/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CarsList extends StatelessWidget {

  CarsList(){
    carListController.update_data();
  }

  CarListController carListController = Get.find();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx((){
        return  SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _body(context),
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
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios,size: 20,),
              )
          ),
          Container(
            child: GestureDetector(
              onTap: (){

              },
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset('assets/images/filter.svg',color: Theme.of(context).dividerColor,),
                  ),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate('filter'),style: Theme.of(context).textTheme.headline2),
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

              },
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    child: SvgPicture.asset('assets/images/sort.svg',color: Theme.of(context).dividerColor,),
                  ),
                  const SizedBox(width: 10),
                  Text(App_Localization.of(context).translate('sort'),style: Theme.of(context).textTheme.headline2),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15,left: 15),
            child: IconButton(
              onPressed: (){
                Get.to(()=>Settings());
              },
              icon: const Icon(Icons.menu),
            ),
          )
        ],
      ),
    );
  }

  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child:carListController.loading.value?Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
      ): ListView.builder(
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
            child: Image.asset('assets/images/car.png'),
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
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Image.asset('assets/images/car.png'),
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




}


