import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/models/news_model.dart';
import 'package:flutter_defualt_project/provider/news_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({super.key, required this.newsModel, required this.index});

  final NewsModel newsModel;
  final int index;

  final NewsProvider newsProvider = NewsProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
                              "Are you sure you want to delete this New!",
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
                                          .read<NewsProvider>()
                                          .deleteNews(id: newsModel.id ?? 0);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "New success deleted!")));
                                      Navigator.pop(context);
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
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                newsModel.newsDataTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  showDialog(
                    barrierColor:Colors.black87 ,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child:
                        PhotoView(imageProvider: NetworkImage(newsModel.newsDataImg),backgroundDecoration: const BoxDecoration(color: Colors.transparent),),
                      );
                    },
                  );
                },
                child: Hero(
                  tag: index,
                  child: CachedNetworkImage(imageUrl: newsModel.newsDataImg),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                newsModel.newsDataBody,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
