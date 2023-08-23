import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_defualt_project/ui/auth/widgets/global_button.dart';
import 'package:flutter_defualt_project/ui/auth/widgets/global_textfield.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_defualt_project/utils/extension.dart';
import 'package:flutter_defualt_project/utils/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key, required this.onChanged, required this.parentContext});

  final VoidCallback onChanged;
  final BuildContext parentContext;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [Expanded(
          child: ListView(
            children: [
              80.ph,
              GlobalTextField(
                hintText: "Username",
                textInputType: TextInputType.name,
                controller: context.read<AuthCubit>().userController,
              ),
              24.ph,
              GlobalTextField(
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                controller: context.read<AuthCubit>().emailController,
              ),
              24.ph,
              GlobalTextField(
                isPassword: true,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                controller: context.read<AuthCubit>().passwordController,
              ),
              24.ph,
              GlobalTextField(isPassword: true,
                hintText: "Confirm Password",
                textInputType: TextInputType.visiblePassword,
                controller:
                context.read<AuthCubit>().confirmPasswordController,
              ),
              24.ph,
              GlobalButton(
                  title: "Sign up",
                  onTap: () {
                    context.read<AuthCubit>().changeSignUpState(context);
                  }),
              24.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        onChanged.call();
                        context.read<AuthCubit>().loginButtonPressed();
                      },
                      child: Text("Log In",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.c_3669C9),))
                ],
              ),
            ],
          ),
        )],
      ),
    );
  }
}
