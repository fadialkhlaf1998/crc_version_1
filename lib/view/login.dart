import 'package:crc_version_1/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogIn extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: loginController.loading.value?Center(child: CircularProgressIndicator(),):Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TextField(
                    controller: loginController.username,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: loginController.submited.value&&loginController.username.text.isEmpty?Colors.red:Colors.black)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: loginController.submited.value&&loginController.username.text.isEmpty?Colors.red:Colors.grey)
                        ),
                        label: Text("username")
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TextField(
                    controller: loginController.password,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: loginController.submited.value&&loginController.password.text.isEmpty?Colors.red:Colors.black)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: loginController.submited.value&&loginController.password.text.isEmpty?Colors.red:Colors.grey)
                        ),
                        label: Text("password")
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                   loginController.submite(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: 50,
                    color: Colors.blue,
                    child: Center(child: Text("submite")),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
