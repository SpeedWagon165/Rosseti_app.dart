import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rosseti_project/models/profile_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioBase {
  final Dio dio;

  DioBase() : dio = Dio() {
    dio.options.baseUrl = 'https://phystechlab.ru/rosseti/public/api/';
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options); // Продолжаем запрос
        },
      ),
    );
  }

  final String tokenKey = 'tokenKey';

  Future<void> postData(String data, VoidCallback onSuccess) async {
    try {
      final response = await dio.post('auth/phone', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final responseData = response.data;
        if (responseData['success'] == true) {
          onSuccess(); // Вызов функции навигации
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> postPhoneCode(String code, VoidCallback onSuccess) async {
    try {
      final response = await dio.post('auth/verify-code', data: {"code": code});
      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData['token'];
        saveToken(token);
        setupInterceptors();
        if (responseData['success'] == true) {
          onSuccess();
        }

        return token;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> setupInterceptors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenKey);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<void> sendData(FormData formData) async {
    try {
      final response = await dio.post(
        '/suggestions/store',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Данные успешно отправлены!');
      } else {
        debugPrint(
            'Ошибка при отправке данных. Код ошибки: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Ошибка при отправке данных: $error');
    }
  }

  Future<UserInfo?> profileInfo() async {
    try {
      final response = await dio.get('/user');
      final responseData = response.data;

      if (responseData != null) {
        return UserInfo.fromJson(responseData);
      } else {
        return null;
      }
    } catch (error) {
      debugPrint('Ошибка при загрузке данныx: $error');
      return null;
    }
  }

  // Future<void> fetchDataFromServer(
  //     Function(List<Map<String, dynamic>>) onUpdate) async {
  //   try {
  //     final response = await dio.get('/topics');
  //     final responseData = response.data;
  //
  //     List<Map<String, dynamic>> newTopics =
  //         List<Map<String, dynamic>>.from(responseData['topics']);
  //     onUpdate(newTopics);
  //   } catch (error) {
  //     debugPrint('Ошибка при загрузке данных: $error');
  //   }
  // }

  Future<bool> saveToken(String token) async {
    debugPrint('token here');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(tokenKey, token);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenKey);
    return token;
  }
}
