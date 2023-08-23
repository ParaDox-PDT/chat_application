import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/app/app.dart';
import 'package:flutter_defualt_project/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_defualt_project/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_defualt_project/ui/auth/auth_screen.dart';
import 'package:flutter_defualt_project/ui/home/home_screen.dart';

class AuthScreenWithCubit extends StatefulWidget {
  const AuthScreenWithCubit({super.key});

  @override
  State<AuthScreenWithCubit> createState() => _AuthScreenWithCubitState();
}

class _AuthScreenWithCubitState extends State<AuthScreenWithCubit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, Auth>(
        builder: (context, state) {
          if (state is InitialState) {
            return const App();
          }
          if (state is LoginState) {
            return const AuthScreen();
          }

          if (state is SignUpState) {
            return const AuthScreen();
          }

          if (state is LoggedInState) {
            return const HomeScreen();
          }
          return const App();
        },
      ),
    );
  }
}
