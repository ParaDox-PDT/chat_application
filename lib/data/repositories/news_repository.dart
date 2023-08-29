import 'package:flutter_defualt_project/data/models/universal_data.dart';
import 'package:flutter_defualt_project/data/network/api_service.dart';

class NewsRepository {
  final ApiService apiService;

  NewsRepository({required this.apiService});

  Future<UniversalData> postNotification(
          {required String title,
          required String description,
          required String image}) async =>
      apiService.postNotification(
          title: title, description: description, image: image);
}
