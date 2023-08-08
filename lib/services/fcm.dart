import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_defualt_project/data/local/db/local_database.dart';
import 'package:flutter_defualt_project/data/models/news_model.dart';

import '../provider/news_provider.dart';
import 'local_notification_service.dart';

Future<void> initFirebase() async {
  NewsProvider newsProvider=NewsProvider.instance;
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  await FirebaseMessaging.instance.subscribeToTopic("news");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.data["title"]} va ${message.notification!.title} in foreground");
    LocalNotificationService.instance.showFlutterNotification(message);
    newsProvider.insertNews(newsModel: NewsModel(
      newsTitle: message.notification?.title ?? "",
      newsBody: message.notification?.body ?? "",
      newsDataTitle: message.data["title"],
      newsDataBody: message.data["body"],
      newsDataImg: message.data["image"],
      newsDataDatetime: DateTime.now().toString(),
    ),);
    newsProvider.getNews();
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  handelMessage(RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.data["title"]} va ${message.notification!.title} in terminated");
    LocalNotificationService.instance.showFlutterNotification(message);
    newsProvider.insertNews(newsModel: NewsModel(
      newsTitle: message.notification?.title ?? "",
      newsBody: message.notification?.body ?? "",
      newsDataTitle: message.data["title"],
      newsDataBody: message.data["body"],
      newsDataImg: message.data["image"],
      newsDataDatetime: DateTime.now().toString(),
    ),);
    newsProvider.getNews();
  }

  RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handelMessage(remoteMessage);
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NewsProvider newsProvider=NewsProvider.instance;
  newsProvider.insertNews(newsModel: NewsModel(
    newsTitle: message.notification?.title ?? "",
    newsBody: message.notification?.body ?? "",
    newsDataTitle: message.data["title"],
    newsDataBody: message.data["body"],
    newsDataImg: message.data["image"],
    newsDataDatetime: DateTime.now().toString(),
  ),);
  newsProvider.getNews();
  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.data["title"]} va ${message.notification!.title} in background");
}
