import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/tab_box_cubit/tab_box_state.dart';
import 'package:flutter_defualt_project/ui/task_screens/tab_box_task/main_screen.dart';

class TabBoxCubit extends Cubit<TabBoxState> {
  TabBoxCubit() : super(TabBoxState(currentScreen: MainScreen()));

  changeScreen(int index) {
    emit(
      state.copyWith(
        currentScreen: state.screens[index],
      ),
    );
  }
}
