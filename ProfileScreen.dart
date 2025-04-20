
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_chat/api/apis.dart';
import 'package:x_chat/helper/dialogs.dart';
import 'package:x_chat/models/Chat_user.dart';
import 'package:x_chat/screens/auth/login_screen.dart';

import '../main.dart';



class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors:
          [
            Color(0xffa1c4fd),
            Color(0xffc2e9fb),
            Color(0xfffccb90)
          ]
          )
      ),
      child: Scaffold(
        appBar: AppBar(

          title: Text("Profile Screen"),



        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red.shade400,
            onPressed: () async{
              Dialogs.showProgressbar(context);
            await APIs.Auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value){

                // remove from profile
                Navigator.pop(context);
                // remove from home Screen

                Navigator.pop(context);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              });
            });



          },icon:   Icon(Icons.logout,color: Colors.white,),
          label: Text("SignOut",style: TextStyle(color: Colors.white),),
          ),
          
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width*.04),
          child: Column(
            children: [
               SizedBox(
                 width: mq.width,
                 height: mq.height*.03,

               ),
                Stack(
                  children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height*.3),
                    child: CachedNetworkImage(

                      width: mq.width*.4,
                      height: mq.height*.2,
                      fit: BoxFit.fill,

                      imageUrl: (widget.user.image),
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>   CircleAvatar(child: Icon(Icons.person,color: Colors.purple.shade200,size: 80,)),
                    ),
                                  ),
                    Positioned(
                      bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: (){},
                          child: Icon(Icons.edit,color: Colors.purple.shade300,)
                          ,color: Colors.white,
                          shape: CircleBorder(),))
                  ],
                ),
              SizedBox(
          height: mq.height*.02,
              ),

              Text(widget.user.email,style: TextStyle(color: Colors.black54,fontSize: 16),),
              SizedBox(
                height: mq.height*.02,
              ),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                  hintText: ' eg : vaibhav joshi',
                  prefixIcon: Icon(Icons.person, color: Colors.purple.shade200),
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),

              SizedBox(
                height: mq.height*.02,
              ),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                  hintText: ' eg : Feeling Happy',
                  prefixIcon: Icon(Icons.info, color: Colors.purple.shade200),
                  labelText: "About",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height*.02,
              ),
              Container(
                width: 200,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                  onPressed: (){}, label:  Text("Update",style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.edit,color: Colors.white,),),
              )

            ],
          ),
        )

      ),
    );
  }
}
