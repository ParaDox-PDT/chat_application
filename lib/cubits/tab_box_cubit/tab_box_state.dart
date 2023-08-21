import 'package:flutter/material.dart';

import '../../ui/task_screens/tab_box_task/favorite_screen.dart';
import '../../ui/task_screens/tab_box_task/main_screen.dart';
import '../../ui/task_screens/tab_box_task/user_screen.dart';

class TabBoxState{
  TabBoxState({required this.currentScreen});
  Widget currentScreen;

  TabBoxState copyWith({
    Widget? currentScreen,

  }) =>
      TabBoxState(
       currentScreen: currentScreen ?? this.currentScreen
      );

  final List<Widget> screens=[MainScreen(),UserScreen(),FavoriteScreen()];

}