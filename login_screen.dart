import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_chat/api/apis.dart';
import 'package:x_chat/helper/dialogs.dart';
import 'package:x_chat/home_screen.dart';

import '../../main.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {




  bool _isAnimate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( const Duration(milliseconds: 500), (){
      setState(() {
        _isAnimate = true;
      });
    });
  }


  _handlegoogleBtnclick(){

    //showing progress Bar //


    Dialogs.showProgressbar(context);
      _signInWithGoogle().then((user) async {

        Navigator.pop(context);
        if(user!=null){
          log('\nuser : ${user.user}');
          log('\nuseradditinalInfo : ${user.additionalUserInfo} ');
        }
         if( await APIs.UserExits()){
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
             return const HomeScreen();
           }));

         }else{
            await APIs.CreateUser().then((value){
              return Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                return const HomeScreen();
              }));
            }

            );
         }

      });
  }

  Future<UserCredential?> _signInWithGoogle() async {
   try{

     await InternetAddress.lookup('google.com');
     // Trigger the authentication flow
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     // Obtain the auth details from the request
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );

     // Once signed in, return the UserCredential
     return await APIs.Auth.signInWithCredential(credential);
   }catch(ex){
   log('\n_signInWithGoogle : $ex');
   Dialogs.showSnackbar(context, 'Something went Wrong (Check Internet Connection!)');
     return null;
   }
  }

  @override

  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(" Welcome To X chat"),



      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              top: mq.height* .15,
              right : _isAnimate ? mq.width* .25 : - mq.width * .5,
              width: mq.width* .5,
              duration: const Duration(seconds: 1),

              child: Image.asset("assets/images/messaging.png")),

          Positioned(
              bottom: mq.height* .15,
              left: mq.width* .05,
              width: mq.width* .9,
              height: mq.height* .07,

              child:


              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade50,shape: StadiumBorder(),elevation: 1),
                onPressed: (){
                 _handlegoogleBtnclick();


                }, label: Text("SignIn With Google",style: TextStyle(color: Colors.black87),),icon: Container(
                  height: 27,
                  child: Image.asset("assets/images/google.png",)) ,)
          )
            ],
      ),


    );
  }
}
