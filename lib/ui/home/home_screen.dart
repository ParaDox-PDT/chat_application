import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            context.read<AuthProvider>().logOutUser(context);
          },
          child: Text("Log Out",style: Theme.of(context).textTheme.titleLarge,),
        ),
      ),
    );
  }
}