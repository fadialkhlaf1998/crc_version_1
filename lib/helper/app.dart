import 'dart:io';

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class App {
  static Color primery = Color(0XFFFD6001);
  static Color secundry = Color(0XFF191919);

  static textBlod(Color color, double size) {
    return TextStyle(color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
        overflow: TextOverflow.ellipsis);
  }

  static textNormal(Color color, double size) {
    return TextStyle(
        color: color, fontSize: size, overflow: TextOverflow.ellipsis);
  }


  static sucss_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
        backgroundColor: primery,
      ),
    );
  }
  static error_msg(BuildContext context,String err){
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message:
        err,
      ),
    );
  }

  static info_msg(BuildContext context,String info){
    return showTopSnackBar(
      context,
      CustomSnackBar.info(
        message:
        info,
        backgroundColor: primery,
      ),
    );
  }
  static openwhatsapp(BuildContext context,String msg) async{
    var whatsapp ="971526924021";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$msg";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse(msg)}";

    String url = WA_url(whatsapp,msg);

    if( await canLaunch(url)){
      await launch(url);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Can not open whatsapp")));

    }
  }

  static String WA_url(String phone,String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }


}