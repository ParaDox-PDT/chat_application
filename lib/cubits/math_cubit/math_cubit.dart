import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/math_cubit/math_state.dart';

class MathCubit extends Cubit<MathState> {
  MathCubit() : super(MathState());

  updateFirstNum(int newNum) {
    emit(state.copyWith(firstNum: newNum));
    updateAnswer();
  }

  updateSecondNum(int newNum) {
    emit(state.copyWith(secondNum: newNum));
    updateAnswer();
  }

  updateAnswer() {
    emit(
      state.copyWith(
        answer: pow(state.firstNum, state.secondNum).toInt()
      ),
    );
  }
}
