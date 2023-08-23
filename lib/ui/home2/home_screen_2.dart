import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.mathScreen);
              },
              child: Text(
                "Math task",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 30.h,),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.tabBox);
              },
              child: Text(
                "Tab Box task",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 30.h,),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.authScreenCubit);
              },
              child: Text(
                "Login task",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 30.h,),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.task);
              },
              child: Text(
                "Task",
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
