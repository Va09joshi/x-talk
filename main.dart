import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_chat/home_screen.dart';
import 'package:x_chat/screens/auth/login_screen.dart';
import 'package:x_chat/splash_screen.dart';

late Size mq;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xffa1c4fd),
          Color(0xffc2e9fb),
          Color(0xfffccb90)
        ])
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'X Talk',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black54
            ),
            elevation: 50,
            titleTextStyle:  TextStyle(fontSize: 21,fontWeight: FontWeight.w600,color: Colors.black87),
            centerTitle: true,
            backgroundColor: Colors.white60,
          )
        ),
        home: SplashScreen()
      ),
    );
  }
}


