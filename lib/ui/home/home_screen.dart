import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/provider/news_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsProvider newsProvider = NewsProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  newsProvider.deleteAllNews();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: context.watch<NewsProvider>().news.isEmpty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(color: Colors.black),
              ),
            )
          : ListView(
              children: [
                ...List.generate(
                  context.watch<NewsProvider>().news.length,
                  (index) => ZoomTapAnimation(
                    onTap: (){

                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.grey.shade200,
                        border: Border.all(width: 1,color: Colors.grey.shade400),
                        boxShadow: const [BoxShadow(spreadRadius: 4,color: Colors.black54,blurRadius: 12,offset: Offset(3,10))]
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: CachedNetworkImage(
                              imageUrl: context
                                  .watch<NewsProvider>()
                                  .news[index]
                                  .newsDataImg,
                              width: 120.w,
                              height: 90.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Expanded(
                                  child: SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      context
                                          .watch<NewsProvider>()
                                          .news[index]
                                          .newsDataTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
