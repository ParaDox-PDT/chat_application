import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/default_model.dart';
import '../models/universal_response.dart';

class ApiProvider {
  Future<UniversalData> postNotification(
      {required String title,
      required String description,
      required String image}) async {
    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      http.Response response = await http.post(uri, headers: <String, String>{
        "content-type": "application/json",
        "Authorization":
            "key=AAAArKpRnc4:APA91bEo6IvoPSs6RLdC4TaaTxYDa3K83j58n66KNW_KrJHE0zNA65ByRd_hf0dDY7zmj2X_RprpiScQPl_WIVwOfkswmBi9PO5Scz8tU0D2hazbpJZybmUb5QKQrxQmcMvZ-s1MKuU0"
      },body: jsonEncode(<String,dynamic>{
        "to":"/topics/news",
        "notification":{
          "title":"NEWS APP",
          "body":"YANGILIKLAR DUNYOSI"
        },"data":{
          "title":title,
          "body":description,
          "image":image
        }
      }));

      if (response.statusCode == 200) {
        return UniversalData(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => DefaultModel.fromJson(e))
                    .toString() ??
                []);
      }
      return UniversalData(error: "ERROR");
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
