import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_defualt_project/data/firebase/auth_service.dart';
import 'package:flutter_defualt_project/data/models/user_model.dart';

import '../../data/models/universal_response.dart';
import '../../utils/ui_utils/error_message_dialog.dart';
import '../../utils/ui_utils/loading_dialog.dart';

class AuthCubit extends Cubit<Auth> {
  AuthCubit() : super(InitialState());

  final AuthService firebaseService = AuthService();

  changeLoginState() {
    emit(LoginState());
  }

  Future<void> changeSignUpState(BuildContext context) async{
    await checkPassword(context);
    emit(LoggedInState());
  }

   changeLoggedInState(BuildContext context)async {
   await loginUser(context);
    emit(LoggedInState());
  }

  Future<void> changeLoggedOutSate(BuildContext context) async{
    await logOutUser(context);
    emit(LoggedOutState());
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String userUrl = "";

  loginButtonPressed() {
    emailController.clear();
    userController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  signUpButtonPressed() {
    emailController.clear();
    passwordController.clear();
  }

  checkPassword(BuildContext context) {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (password == confirmPassword) {
      signUpUser(context);
    } else {
      showErrorMessage(
          message: "Password and Confirm Password are not the same! Try Again",
          context: context);
    }
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    // showLoading(context: context);
    UniversalData universalData =
        await firebaseService.signUpUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        addUser(context: context);
        loginButtonPressed();
        showConfirmMessage(message: "User signed Up", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    // showLoading(context: context);
    UniversalData universalData =
        await firebaseService.loginUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        loginButtonPressed();
        showConfirmMessage(message: "User logged!", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseService.logOutUser();
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
            message: universalData.data as String, context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseService.signInWithGoogle();
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
            message: "User Signed Up with Google!", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> addUser({required BuildContext context}) async {
    String userName = userController.text;
    String userEmail = emailController.text;

    if (userName.isNotEmpty && userEmail.isNotEmpty && userUrl.isNotEmpty) {
      UserModel userModel = UserModel(
        userId: "",
        userName: userName,
        email: userEmail,
        imageUrl: userUrl,
        createdAt: DateTime.now().toString(),
      );
      // showLoading(context: context);
      UniversalData universalData =
          await firebaseService.addUser(userModel: userModel);
      // if(context.mounted){
      //   hideLoading(dialogContext: context);
      // }

      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showConfirmMessage(
              context: context, message: universalData.data as String);
          loginButtonPressed();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    } else {
      showErrorMessage(message: "Maydonlar to'liq emas", context: context);
    }
  }
}
