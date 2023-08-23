import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/task_cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState(currentState: false));

  List<int> indexes=[];

  changeState(int index) {
    if(indexes.contains(index)){
      indexes.remove(index);
    }else{
      indexes.add(index);
    }

    emit(
      state.copyWith(currentState: !state.currentState),
    );
  }
}
