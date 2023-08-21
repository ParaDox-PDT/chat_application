import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/math_cubit/math_cubit.dart';
import 'package:flutter_defualt_project/cubits/tab_box_cubit/tab_box_cubit.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'data/local/storage_repository/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TabBoxCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (_) => MathCubit(),
          lazy: true,
        )
      ],
      child: const MyApp(),
    );
  }
}

// runApp(
//   MultiProvider(
//     providers: [
//       ChangeNotifierProvider(
//         create: (context) => AuthProvider(
//           firebaseService: AuthService(),
//         ),
//         lazy: true,
//       ),
//       ChangeNotifierProvider(
//         create: (context) => ProfileProvider(
//           profileService: ProfileService(),
//         ),
//         lazy: true,
//       )
//     ],
//     child: const MyApp(),
//   ),
// );

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
