import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_chat/api/apis.dart';
import 'package:x_chat/home_screen.dart';
import 'package:x_chat/screens/auth/login_screen.dart';

import '../../main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isAnimate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( const Duration(milliseconds: 2000), (){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge
      );
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));


       if(APIs.Auth.currentUser!=null){
         log('\nuser : ${APIs.Auth.currentUser}');

         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
           return HomeScreen();
         }));
       }else{
         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
           return LoginScreen();
         }));
       }


    });
  }

  @override

  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;

    return Scaffold(

      body: Container(
        color: Colors.purple.shade50,
        child: Stack(
          children: [
            Positioned(
                top: mq.height* .35,
                right :  mq.width* .25,
                width: mq.width* .5,


                child: Image.asset("assets/images/teamwork.png")),

            Positioned(
                bottom: mq.height* .35,
                width: mq.width,


                child: Text("A realTime Communication Talk",textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color: Colors.purple.withOpacity(1),letterSpacing: .3),)
            )


          ],
        ),
      ),


    );
  }
}
