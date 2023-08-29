import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/firebase/upload_service.dart';
import 'package:flutter_defualt_project/data/models/universal_data.dart';
import 'package:flutter_defualt_project/data/repositories/news_repository.dart';
import 'package:flutter_defualt_project/utils/ui_utils/error_message_dialog.dart';
import 'package:flutter_defualt_project/utils/ui_utils/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_notification_state.dart';

class PostNotificationCubit extends Cubit<PostNotificationState> {
  PostNotificationCubit({required this.newsRepository})
      : super(PostNotificationInitial());

  final NewsRepository newsRepository;
  bool isLoading = false;
  String imageUrl = "";

  Future<void> postNotification(
      {required String title,
      required String description}) async {
    isLoading = true;
    UniversalData universalData = await newsRepository.postNotification(
        title: title, description: description, image: imageUrl);
    isLoading=false;
    if (universalData.error.isEmpty) {
      imageUrl="";
      emit(PostNotificationSuccessState());
    } else {
      emit(PostNotificationErrorState(errorText: universalData.error));
    }
  }

  Future<void> uploadCategoryImage(
    BuildContext context,
    XFile xFile,
  ) async {
    showLoading(context: context);
    UniversalData data = await FileUploader.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      imageUrl = data.data as String;
      emit(PostNotificationImageUploadState());
    } else {
      if (context.mounted) {
        showErrorMessage(context: context,message: data.error);
      }
    }
  }
}
