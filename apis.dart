import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:x_chat/models/Chat_user.dart';

class APIs{




  static FirebaseAuth Auth = FirebaseAuth.instance;
  static FirebaseFirestore Firestore = FirebaseFirestore.instance;
static late ChatUser me;

  static  User get users => Auth.currentUser!;

  // check users exits or not in this
  static Future<bool> UserExits() async{
    return (await Firestore.collection('users').doc(users.uid).get()).exists;


  }
  //for getting current user info

  static Future<void> getSelfinfo() async{
    await Firestore.collection('users').doc(users.uid).get().then((user) async {
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
        log("My Data : ${user.data()}");

      }else{
         await CreateUser().then((value) => getSelfinfo());
      }
    });


  }


  static Future<void> CreateUser() async{
 
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    
    final chatuser = ChatUser(id: users.uid,
   name: users.displayName.toString(),
   email: users.email.toString(),
   about: "hey I am in X talk",
   image:  users.photoURL.toString(),
   LastActive: time,
   PushToken: '',
   CreatedAt: time ,
   isOnline: false ,



 );

    return await Firestore.collection('users').doc(users.uid).set(chatuser.toJson());

  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallusers(){
        return Firestore.collection("users").where('id',isNotEqualTo: users.uid).snapshots();
  }
}