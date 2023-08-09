import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/firebase/auth_service.dart';
import 'package:flutter_defualt_project/data/firebase/profile_service.dart';
import 'package:flutter_defualt_project/provider/auth_provider.dart';
import 'package:flutter_defualt_project/provider/news_provider.dart';
import 'package:flutter_defualt_project/provider/post_provider.dart';
import 'package:flutter_defualt_project/provider/profile_provider.dart';
import 'package:flutter_defualt_project/services/fcm.dart';
import 'package:flutter_defualt_project/services/local_notification_service.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'data/local/storage_repository/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();

  await initFirebase();
  await LocalNotificationService.instance.setupFlutterNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            firebaseService: AuthService(),
          ),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            profileService: ProfileService(),
          ),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider.instance,
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 783),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
