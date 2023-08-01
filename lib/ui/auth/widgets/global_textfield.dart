import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({super.key, required this.hintText, required this.textInputType,this.isPassword=false, required this.controller});
  final String hintText;
  final TextInputType textInputType;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.grey,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: textInputType,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.black),
        decoration: InputDecoration(
            hintText: hintText,
            helperStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.white)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.white)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.white))),
      ),
    );
  }
}
