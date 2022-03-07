import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/controller/home_controller.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class Home extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              _header(context),
              const SizedBox(height: 30,),
              _searchBar(context),
              const SizedBox(height: 30,),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: !homeController.chooseModel.value ?
                _brandBody(context) : _modelsBody(context),
              ),
            ],
          ),
        ),
      );
    });
  }


  _header(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height  * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child:  homeController.chooseModel.value ? SizedBox(
              width: 50,
              child: GestureDetector(
                onTap: (){
                  homeController.chooseModel.value = false;
                },
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).dividerColor,),
              ),
            ) : SizedBox(width: 50),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.07,
                child: MyTheme.isDarkTheme ?  Image.asset('assets/images/logo_dark.png'): Image.asset('assets/images/logo_light.png'),
              ),
              Text(App_Localization.of(context).translate('welcome_to_crc'), style: Theme.of(context).textTheme.headline2),
              !homeController.chooseModel.value ?
                Text(App_Localization.of(context).translate('please_select_car_brand'), style: Theme.of(context).textTheme.bodyText2)
                    :Text(App_Localization.of(context).translate('please_select_the_vehicle_type'), style: Theme.of(context).textTheme.bodyText2) ,
            ],
          ),
          SizedBox(
            width: 50,
            child: GestureDetector(
              onTap: (){
                homeController.chooseModel.value = true;
              },
              child: Text(App_Localization.of(context).translate('next'),  style: Theme.of(context).textTheme.headline2),
            ),
          ),
        ],
      ),
    );
  }

  _searchBar(BuildContext context){
    return GestureDetector(
      onTap: (){
        // final result = await showSearch(
        //     context: context,
        //     delegate: SearchTextField(suggestion_list: [], homeController: homeController ));
      },
      child:  Container(
        width: MediaQuery.of(context).size.width  * 0.9,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {

              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            Text(App_Localization.of(context).translate('search_here'),style: Theme.of(context).textTheme.headline3)
          ],
        ),
      ),
    );
  }

  _brandBody(context){
    return Obx((){
     return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.68,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child:Text('All car', style: Theme.of(context).textTheme.headline3),
                    ),
                  ),
                  Divider(color: Theme.of(context).dividerColor,thickness: 1,indent: 30,endIndent: 35,)
                ],
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeController.brands.length,
                itemBuilder: (context, index){
                  return Obx((){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            homeController.brandIndex = index.obs;
                            homeController.chooseBrand(index);
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(homeController.brands[index].title, style: homeController.brands[index].selected.value ? TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold) : Theme.of(context).textTheme.headline3),
                                homeController.brands[index].selected.value ? Icon(Icons.check,size: 25, color: Theme.of(context).primaryColor) : Text(''),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Theme.of(context).dividerColor,thickness: 1,indent: 30,endIndent: 35,)
                      ],
                    );
                  });
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  _modelsBody(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.68,
      child: ListView.builder(
        itemCount: homeController.brands[homeController.brandIndex.value].models.length,
        itemBuilder: (context, index){
          return Obx((){
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(homeController.brands[homeController.brandIndex.value].models[index].title, style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor,thickness: 1,indent: 30,endIndent: 35,)
              ],
            );
          });
        },
      ),
    );
  }
}



class SearchTextField extends SearchDelegate<String> {
  final List<String> suggestion_list;
  String? result;
  HomeController homeController;

  SearchTextField(
      {required this.suggestion_list, required this.homeController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [query.isEmpty ? Visibility( child: Text(''), visible: false) : IconButton(
        icon: Icon(Icons.search, color: Colors.white,),
        onPressed: () {
          close(context, query);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: AppBarTheme(
        color: App.primery, //new AppBar color
        elevation: 0,
      ),
      hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
   // homeController.get_products_by_search(query, context);
    close(context, query);
    return Center(
      child: CircularProgressIndicator(
        color: App.primery,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = suggestion_list.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      color: App.primery,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
              style: TextStyle(color: App.primery),
            ),
            onTap: () {
              query = suggestions.elementAt(index);
              close(context, query);
            },
          );
        },
      ),
    );
  }
}