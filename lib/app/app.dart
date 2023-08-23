import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_defualt_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthCubit>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );

          }else if(snapshot.data == null){
           return context.read<AuthCubit>().changeLoginState();

          }else{
           return context.read<AuthCubit>().changeLoggedInState(context);
          }
        },
      ),
    );
  }
}
