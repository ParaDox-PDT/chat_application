import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_defualt_project/cubits/news_cubit/news_cubit.dart';
import 'package:flutter_defualt_project/data/local/storage_repository/storage_repository.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_defualt_project/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSubs = StorageRepository.getBool("subs");

  checking() async {
    isSubs
        ? await FirebaseMessaging.instance.subscribeToTopic("news")
        : await FirebaseMessaging.instance.unsubscribeFromTopic("news");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Switch(
            onChanged: (value) {
              isSubs = !isSubs;
              StorageRepository.putBool("subs", isSubs);
              setState(() {
                checking();
              });
            },
            value: isSubs,
          ),
          title: Lottie.asset(AppImages.appBarIcon,
              height: 56.h, fit: BoxFit.fitHeight),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteNames.pushNotificationScreen);
                },
                icon: Icon(
                  Icons.add,
                  size: 30.sp,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 125.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delete This New",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Roboto"),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Are you sure you want to delete all News!",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto"),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          context
                                              .read<NewsCubit>()
                                              .deleteAllNews();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "News success deleted!")));
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.cleaning_services_rounded,
                  color: Colors.red,
                  size: 30.sp,
                ))
          ],
        ),
        body: BlocConsumer<NewsCubit,NewsState>(
          builder: (context, state) {
            return context.watch<NewsCubit>().news.isEmpty
                ? Center(child: Lottie.asset(AppImages.empty))
                : ListView(
                    children: [
                      ...List.generate(
                        context.watch<NewsCubit>().news.length,
                        (index) => ZoomTapAnimation(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.newsDetail,
                              arguments: {
                                "model": context.read<NewsCubit>().news[index],
                                "index": index
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            width: double.infinity,
                            height: 120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.grey.shade200,
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 4,
                                      color: Colors.black54,
                                      blurRadius: 12,
                                      offset: Offset(3, 10))
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: index,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: CachedNetworkImage(
                                      imageUrl: context
                                          .watch<NewsCubit>()
                                          .news[index]
                                          .newsDataImg,
                                      width: 120.w,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Expanded(
                                            child: SizedBox(
                                              width: 200.w,
                                              child: Text(
                                                context
                                                    .watch<NewsCubit>()
                                                    .news[index]
                                                    .newsDataTitle,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Text(
                                        context
                                            .watch<NewsCubit>()
                                            .news[index]
                                            .newsDataDatetime
                                            .substring(0, 16),
                                        style: TextStyle(
                                            color: AppColors.c_3669C9,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
          listener: (context, state) {
            if(state is NewsSuccessState){
              context.read<NewsCubit>().getNews();
              setState(() {

              });
            }
          },
        ));
  }
}
