import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _init()async{
    await Future.delayed(Duration(seconds: 3));

    if(context.mounted){
      Navigator.pushReplacementNamed(context, RouteNames.appScreen);
    }
  }

  @override
  void initState(){
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen"
        ),
      ),
    );
  }
}
