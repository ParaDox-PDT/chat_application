import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/task_cubit/page_cubit/page_cubit.dart';
import 'package:flutter_defualt_project/cubits/task_cubit/task_cubit.dart';
import 'package:flutter_defualt_project/cubits/task_cubit/task_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Screen",
          style: TextStyle(
              fontSize: 26.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<PageCubit, PageState>(
        builder: (context, state) {
          if (state is PageLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PageInitial) {
            return Center(
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Write here",
                      helperStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      context.read<PageCubit>().changePage();
                    });
                  }, child: Text("Next"))
                ],
              ),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 70.h,
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                          20,
                          (index) => ZoomTapAnimation(
                            onTap: () {
                              context.read<TaskCubit>().changeState(index);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              width: 100.w,
                              color: BlocProvider.of<TaskCubit>(context)
                                      .indexes
                                      .contains(index)
                                  ? Colors.tealAccent
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
