import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/edit_person_controller.dart';
import 'package:crc_version_1/controller/people_list_controller.dart';
import 'package:crc_version_1/helper/api.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/view/edit_person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PeopleList extends StatelessWidget {

  PeopleListController peopleListController = Get.put(PeopleListController());
  //EditPersonController editPersonController = Get.put(EditPersonController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: peopleListController.loading.value == true ?
                Container(
                  width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Lottie.asset('assets/images/Animation.json')
                ) : _body1(context),
              ),
              _appBar(context),
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
                  Get.back();
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

  _body(context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Obx((){
              print( peopleListController.myPeopleList.isEmpty);
              return peopleListController.myPeopleList.isEmpty
                  ? Container(
                width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: Text(
                        App_Localization.of(context).translate('there_are_no_people_at_the_moment'),
                        style: Theme.of(context).textTheme.bodyText2
                      ),
                    ),
              )
                  :ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peopleListController.myPeopleList.length,
                itemBuilder: (context, index){
                  return  Column(
                    children: [
                      const SizedBox(height: 20),
                      Obx((){
                        return Container(
                          height:  MediaQuery.of(context).size.height * 0.32,
                          width:  MediaQuery.of(context).size.width * 0.9,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              peopleListController.currentIndex = index.obs;
                                              //editPersonController.personIndex = index.obs;
                                              Get.to(()=>EditPerson());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit,size: 20,color: Theme.of(context).backgroundColor,),
                                                  const SizedBox(width: 2),
                                                  Text(App_Localization.of(context).translate('edit'),style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            )
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              peopleListController.deletePersonFromTheList(index);
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete,size: 20,color: Theme.of(context).backgroundColor),
                                                  SizedBox(width: 2),
                                                  Text(App_Localization.of(context).translate('delete'),style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                    Text(peopleListController.myPeopleList[index].name,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Text(peopleListController.myPeopleList[index].languages,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
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
                                          child: const Icon(Icons.phone,size: 20,color: Colors.white),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(peopleListController.myPeopleList[index].phone,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Divider(thickness: 1,height: 20,indent: 10,endIndent: 10,color: Theme.of(context).backgroundColor.withOpacity(0.2),),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(App_Localization.of(context).translate('hid_or_show'),style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            child:  Switch(
                                              activeColor: Theme.of(context).primaryColor,
                                              value: peopleListController.myPeopleList[index].availableSwitch.value,
                                              onChanged: (bool value) {
                                                peopleListController.changeAvailability(index);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).dividerColor,
                                    border: Border.all(width: 1,color:Theme.of(context).dividerColor.withOpacity(0.3)),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(Api.url + 'uploads/' + peopleListController.myPeopleList[index].image),
                                    )
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  _body1(context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Obx((){
              print( peopleListController.myPeopleList.isEmpty);
              return peopleListController.myPeopleList.isEmpty
                  ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Text(
                      App_Localization.of(context).translate('there_are_no_people_at_the_moment'),
                      style: Theme.of(context).textTheme.bodyText2
                  ),
                ),
              )
                  :ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peopleListController.myPeopleList.length,
                itemBuilder: (context, index){
                  return  Column(
                    children: [
                      const SizedBox(height: 20),
                      Obx((){
                        return Container(
                          height:  MediaQuery.of(context).size.height * 0.32,
                          width:  MediaQuery.of(context).size.width * 0.9,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: (){
                                                peopleListController.currentIndex = index.obs;
                                                //editPersonController.personIndex = index.obs;
                                                Get.to(()=>EditPerson());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit,size: 20,color: Theme.of(context).backgroundColor,),
                                                    const SizedBox(width: 2),
                                                    Text(App_Localization.of(context).translate('edit'),style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              )
                                          ),
                                          GestureDetector(
                                              onTap: (){
                                                peopleListController.deletePersonFromTheList(index);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete,size: 20,color: Theme.of(context).backgroundColor),
                                                    SizedBox(width: 2),
                                                    Text(App_Localization.of(context).translate('delete'),style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          Divider(thickness: 1,height: 20,indent: 10,endIndent: 10,color: Theme.of(context).backgroundColor.withOpacity(0.2),),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.85,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(App_Localization.of(context).translate('hid_or_show'),style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                                Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context).size.width * 0.1,
                                                  child:  Switch(
                                                    activeColor: Theme.of(context).primaryColor,
                                                    value: peopleListController.myPeopleList[index].availableSwitch.value,
                                                    onChanged: (bool value) {
                                                      peopleListController.changeAvailability(index);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).dividerColor,
                                        border: Border.all(width: 1,color:Theme.of(context).dividerColor.withOpacity(0.3)),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(Api.url + 'uploads/' + peopleListController.myPeopleList[index].image),
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(peopleListController.myPeopleList[index].name,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(peopleListController.myPeopleList[index].languages,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
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
                                        child: const Icon(Icons.phone,size: 20,color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(peopleListController.myPeopleList[index].phone,style:  TextStyle(color: Theme.of(context).backgroundColor,fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

}
