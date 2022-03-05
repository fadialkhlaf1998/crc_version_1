import 'package:crc_version_1/controller/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(color: Colors.black,),
        ),
      ),
    );
  }
}
