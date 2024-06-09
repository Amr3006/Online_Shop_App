import 'package:dio/dio.dart';

class dioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {"lang": "en", "Content-Type": "application/json"}));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
        String language = "en",
      String token = ""}) async {
    dio.options.headers = {
      "lang": language,
      "Content-Type": "application/json",
      "Authorization": token
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required Map<String,dynamic> data,
    required String url,
    String language = "en",
    String token = "",
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token,
      "lang" : language
    };
    return await dio.post(url, queryParameters: query,
        data: data);
  }

  static Future<Response> putData({
    required Map<String,dynamic> data,
    required String url,
    String language = "en",
    String token = "",
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token,
      "lang" : language
    };
    return await dio.put(url, queryParameters: query,
        data: data);
  }
}
