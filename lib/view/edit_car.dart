import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/edit_car_controller.dart';
import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:crc_version_1/controller/my_car_list_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EditCar extends StatelessWidget {

  EditCarController editCarController = Get.put(EditCarController());
  MyCarListController myCarListController = Get.find();
  IntroController introController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              editCarController.imagePage.value == false
              ? SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09,bottom: MediaQuery.of(context).size.height * 0.13),
                    //height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.09,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            _header(context),
                            const SizedBox(height: 30),
                            _body(context),
                          ],
                        ),
                      ],
                    ),
                ),
              )
              : SingleChildScrollView(
                child: _editImageList(context),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _appBar(context),
                  AnimatedSwitcher(
                   duration:const Duration(milliseconds: 100),
                   child: MediaQuery.of(context).viewInsets.bottom == 0 ? _footer(context) : Text(''),
                  ),
                ],
              ),
              editCarController.loading.value == false
                  ? Text('')
                  :  WillPopScope(
                  onWillPop: ()async => false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Theme.of(context).dividerColor.withOpacity(0.9),
                        child: Container(
                          child: Lottie.asset('assets/images/data.json'),
                        ),
                      ),
                      Text('Saving your person information',
                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Theme.of(context).backgroundColor)),
                    ],
                  )
              )
            ],
          ),
        ),
      );
    });
  }


  _appBar(context){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
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
                    //Get.back();
                    editCarController.editPriceOpenList.value = false;
                    editCarController.editImageList.value = false;
                  },
                  icon: const Icon(Icons.arrow_back_ios,size: 20,),
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MyTheme.isDarkTheme.value ? const AssetImage('assets/images/logo_dark.png') : const AssetImage('assets/images/logo_light.png'),
                  )
              ),
            ),
            SizedBox(width: 50,)
          ],
        ),
      );

  }

  _header(context){
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:  NetworkImage(editCarController.image!.value)
                )
              ),
            ),
            Column(
              children: [
                Container(
                  child: Text(editCarController.brand!.value,style: Theme.of(context).textTheme.headline2,),
                ),
                Container(
                  child: Text(
                    editCarController.model!.value + ' / '+ editCarController.year!.value,
                    style: Theme.of(context).textTheme.headline3,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _footer(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2)
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: (){
            editCarController.saveInfo();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                App_Localization.of(context).translate('save'),
                style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _body(context){
    return Obx((){
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _brand(context),
            _model(context),
            _year(context),
            _color(context),
            _price(context),
            _location(context),
            _image(context)
          ],
        ),
      );
    });

  }

  _brand(context){
    return Column(
        children: [
          Container(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Brands',style: Theme.of(context).textTheme.bodyText1),
                Text(editCarController.brand!.value,
                    style: TextStyle(fontSize: 15,color: Colors.grey)
                ),
              ],
            ),
          ),
          Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
        ],
      );

  }
  _model(context){
    return Column(
      children: [
        Container(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Car Model',style: Theme.of(context).textTheme.bodyText1),
              Text(editCarController.model!.value,
                  style: TextStyle(fontSize: 15,color: Colors.grey)
              ),
            ],
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }
  _year(context){
    return Column(
      children: [
        Container(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Year',style: Theme.of(context).textTheme.bodyText1),
              Text(editCarController.year!.value,
                  style: TextStyle(fontSize: 15,color: Colors.grey)
              ),
            ],
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }
  _color(context){
    return Column(
      children: [
        Container(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Color',style: Theme.of(context).textTheme.bodyText1),
              Text(editCarController.color!.value,
                  style: TextStyle(fontSize: 15,color: Colors.grey)
              ),
            ],
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }
  _price(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            editCarController.editPrice();
          },
          child: Container(
            //duration: Duration(milliseconds: 500),
            color: Colors.transparent,
            height:  40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily rent',style: Theme.of(context).textTheme.bodyText1),
                Row(
                  children: [
                    Text(editCarController.price!.value,
                        style: TextStyle(fontSize: 15,color: Colors.grey)
                    ),
                    SizedBox(width: 5),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: !editCarController.editPriceOpenList.value ? Icon(Icons.arrow_forward_ios,size: 15) :Icon(Icons.keyboard_arrow_down,size: 23),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 500),
          height: !editCarController.editPriceOpenList.value ? 0 : MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: editCarController.editingController,
                    decoration: InputDecoration(
                        labelText: "Enter a new price",
                        labelStyle: TextStyle(color: Theme.of(context).dividerColor),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            editCarController.getNewPrice();
                            },
                            child: Icon(Icons.check,color: Theme.of(context).primaryColor,)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Theme.of(context).dividerColor.withOpacity(0.5)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }
  _location(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            editCarController.editLocation();
          },
          child: Container(
            color: Colors.transparent,
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Location',style: Theme.of(context).textTheme.bodyText1),
                Row(
                  children: [
                    Text(editCarController.location!.value,
                        style: TextStyle(fontSize: 15,color: Colors.grey)
                    ),
                    SizedBox(width: 5),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 800),
                      child: !editCarController.editLocationOpenList.value ? Icon(Icons.arrow_forward_ios,size: 15) :Icon(Icons.keyboard_arrow_down,size: 23),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 500),
          height: !editCarController.editLocationOpenList.value ? 0 : MediaQuery.of(context).size.height * 0.15,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: editCarController.emirates.length,
                    itemBuilder: (context,index){
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              editCarController.getNewLocation(index);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.31,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage('assets/emirates/${editCarController.emiratesPhoto[index]}'),
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.31,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Text(
                                    editCarController.emirates[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: editCarController.emiratesCheck[index] == true
                                          ? Theme.of(context).primaryColor
                                      : Colors.white,
                                      fontWeight:  editCarController.emiratesCheck[index] == true ? FontWeight.bold : null,
                                      fontSize:  editCarController.emiratesCheck[index] == true ? 17 : 15),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }
  _image(context){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            editCarController.imagePage.value = true;
          },
          child: Container(
            color: Colors.transparent,
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Image',style: Theme.of(context).textTheme.bodyText1),
                Icon(Icons.arrow_forward_ios,size: 18),
              ],
            ),
          ),
        ),
        Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 10,)
      ],
    );
  }




  _editImageList(context){
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: editCarController.imageList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(Api.url + 'uploads/' + editCarController.imageList[index].path)
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                onTap: (){
                                  editCarController.removeImage(index);
                                },
                                child: const Icon(Icons.delete,size: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 20,)
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: editCarController.newImageList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(editCarController.newImageList[index])
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                onTap: (){
                                  editCarController.removeNewImage(index);
                                },
                                child: const Icon(Icons.delete,size: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 1,color: Theme.of(context).dividerColor.withOpacity(0.2),height: 20,)
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: (){
              editCarController.addImage(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Icon(Icons.add,color: Theme.of(context).backgroundColor,),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
