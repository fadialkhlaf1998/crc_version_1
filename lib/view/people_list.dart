import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/people_list_controller.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleList extends StatelessWidget {

  PeopleListController peopleListController = Get.put(PeopleListController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _body(context),
              _app_bar(context),
            ],
          ),
        ),
      );
    });
  }


  _app_bar(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
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
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MyTheme.isDarkTheme ?  AssetImage('assets/images/logo_dark.png') : AssetImage('assets/images/logo_light.png'),
              )
            ),
          ),
          SizedBox(width: 50,)
        ],
      ),
    );
  }

  _body(context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: peopleListController.loading.value?Center(
          child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
        ):
        ListView.builder(
          itemCount: peopleListController.myPeopleList.length,
          itemBuilder: (context, index){
            return Container(
              height:  MediaQuery.of(context).size.height * 0.27,
              width:  MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)
                  ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,size: 20,color: Colors.black,),
                                    SizedBox(width: 2),
                                    Text('Edit',style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )
                            ),
                            GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,size: 20,color: Colors.black,),
                                      SizedBox(width: 2),
                                      Text('Delete',style:  TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                        Text(peopleListController.myPeopleList[index].name,style:  TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(peopleListController.myPeopleList[index].languages,style:  TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.phone,size: 20,color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(peopleListController.myPeopleList[index].phone,style:  TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(thickness: 1,height: 20,indent: 10,endIndent: 10,color: Colors.black.withOpacity(0.2),),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(App_Localization.of(context).translate('hid_or_show'),style:  TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold)),
                              Container(
                                height: 0,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child:  Switch(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: false,// myCarListController.myCarList[index].avilable,
                                  onChanged: (bool value) {
                                    //myCarListController.changeAvailability(index);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(peopleListController.myPeopleList[index].image),
                      )
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }

}
