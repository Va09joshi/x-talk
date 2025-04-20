import 'package:flutter/material.dart';

class Dialogs{


  static void showSnackbar(BuildContext context,String msg ){
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(msg,style: TextStyle(color: Colors.white),)
           ,backgroundColor: Colors.purple.shade200,
           behavior: SnackBarBehavior.floating,));
  }

  static void showProgressbar(BuildContext context ){
   showDialog(context: context, builder: (_) =>  const Center(child: CircularProgressIndicator()));
  }
}