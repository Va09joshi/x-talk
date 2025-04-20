import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_chat/Widgets/chat_user_card.dart';
import 'package:x_chat/api/apis.dart';
import 'package:x_chat/models/Chat_user.dart';
import 'package:x_chat/screens/ProfileScreen.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ChatUser> list = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfinfo();

  }

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
          leading: Icon(CupertinoIcons.home),
         title: Text("X chat"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search)),
            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProfileScreen(user: APIs.me,);
              }));

            }, icon: Icon(Icons.more_vert))
          ],


        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(onPressed: () async{
            await APIs.Auth.signOut();
            await GoogleSignIn().signOut();


          },child: const Icon(Icons.add_box_rounded),),
        ),
        body: StreamBuilder(
          stream: APIs.getallusers(),

          builder : (context,snapshot){

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator(),);

              case ConnectionState.active:
              case ConnectionState.done:




                final Data = snapshot.data!.docs;
                 list = Data.map((e) => ChatUser.fromJson(e.data() ) ).toList() ?? [];
                }

                  if(list.isNotEmpty){
                    return ListView.builder(
                        itemCount: list.length ,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: mq.height*.01),
                        itemBuilder:
                            (context,index){

                          return ChatUserCard(User: list[index]);
                          // return Text("Name : ${list[index]}");
                        });
                  }else{
                    return Center(child: Text("No Connection Found!!",style: TextStyle(fontSize: 16),));
                  }


            }


        ),

      ),
    );
  }
}
