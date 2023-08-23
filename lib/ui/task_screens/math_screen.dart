import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/math_cubit/math_cubit.dart';
import 'package:flutter_defualt_project/cubits/math_cubit/math_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  TextEditingController firstNumController = TextEditingController();
  TextEditingController secondNumController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatter2 = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    MathState mathState = BlocProvider.of<MathCubit>(context).state;
    firstNumController.text = mathState.firstNum.toString();
    secondNumController.text = mathState.secondNum.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Math Screen",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: BlocBuilder<MathCubit, MathState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(26.0.r),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<MathCubit>()
                          .updateFirstNum(double.parse(value));
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [maskFormatter],
                  controller: firstNumController,
                  decoration: const InputDecoration(hintText: "First Num"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<MathCubit>()
                          .updateSecondNum(double.parse(value));
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [maskFormatter2],
                  controller: secondNumController,
                  decoration: const InputDecoration(hintText: "Second Num"),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "Answer:\n${state.answer.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
