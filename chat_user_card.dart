import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:x_chat/models/Chat_user.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser User;

  const ChatUserCard({super.key, required this.User});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: mq.width*.03,vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.purple.shade50,
      child: InkWell(
        onTap: (){
            
        },
        child:  ListTile(
          // leading:  CircleAvatar(child: Icon(Icons.person,color: Colors.purple.shade200,)),
          leading:  ClipRRect(
            borderRadius: BorderRadius.circular(mq.height*.3),
            child: CachedNetworkImage(

              width: mq.width*.1,
              height: mq.height*.1,
              imageUrl: (widget.User.image),scale: 1,
             // placeholder: (context, url) => CircularProgressIndicator(),
               errorWidget: (context, url, error) =>   CircleAvatar(child: Icon(Icons.person,color: Colors.purple.shade200,)),
            ),
          ),
          title: Text((widget.User.name)),
          subtitle: Text(widget.User.about,maxLines: 1,),
          trailing: Container(width: 15,height: 15,decoration: BoxDecoration(
            color: Colors.green.shade500,
            borderRadius: BorderRadius.circular(11)
          ),)

          //Text("12:00",style: TextStyle(color: Colors.black54),),
        ),
      ),
    );
  }
}
