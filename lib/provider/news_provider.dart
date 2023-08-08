import 'package:flutter/foundation.dart';
import 'package:flutter_defualt_project/data/local/db/local_database.dart';

import '../data/models/news_model.dart';

class NewsProvider with ChangeNotifier{

  NewsProvider._(){
  getNews();
}

 static final NewsProvider instance = NewsProvider._();


  List<NewsModel> news=[];


  getNews()async{
    news = await LocalDatabase.getAllNews();
    notifyListeners();
  }

  deleteNews({required int id})async{
    await LocalDatabase.deleteNew(id);
    await getNews();
    notifyListeners();
  }

  deleteAllNews()async{
    await LocalDatabase.deleteAllNews();
    getNews();
    notifyListeners();

  }

  insertNews({required NewsModel newsModel})async{
    await LocalDatabase.insertNews(newsModel);
    await getNews();
    notifyListeners();
  }

}