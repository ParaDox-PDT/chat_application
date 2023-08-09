import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/provider/post_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../utils/colors.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification Service"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: context.watch<PostProvider>().titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: context.watch<PostProvider>().descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(width: 1, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  showBottomSheetDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(14.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.c_3669C9),
                  child: Center(
                    child: context.watch<PostProvider>().imgUrl.isEmpty
                        ? const Text(
                            "Image Not Selected",
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Image.network(context.watch<PostProvider>().imgUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  if (context
                          .read<PostProvider>()
                          .titleController
                          .text
                          .isNotEmpty &&
                      context
                          .read<PostProvider>()
                          .descriptionController
                          .text
                          .isNotEmpty &&
                      context.read<PostProvider>().imgUrl.isNotEmpty) {
                    context.read<PostProvider>().postNotification();
                    Navigator.pop(context);
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 700),
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.symmetric(
                            vertical: 100,
                            horizontal: 20,
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Maydonlari to'ldiring!!!",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.c_3669C9),
                  child: Center(
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      await Provider.of<PostProvider>(context, listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      await Provider.of<PostProvider>(context, listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }
}
