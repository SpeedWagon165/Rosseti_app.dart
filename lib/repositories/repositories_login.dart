import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosseti_project/screens/SMS_code.dart';
import 'package:rosseti_project/screens/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberCheker {
  final Dio dio;

  PhoneNumberCheker() : dio = Dio() {
    print('Это конструктион');
    dio.options.baseUrl = 'https://phystechlab.ru/rosseti/public/api/';
  }

  final String tokenKey = 'tokenKey';

  Future<void> postData(String data, BuildContext context) async {
    print('zavupa pupa');
    try {
      final response = await dio.post('auth/phone', data: data);
      if (response.statusCode == 200) {
        debugPrint(response.toString());
        final responseData = response.data;
        if (responseData['success'] == true) {
          debugPrint(responseData.toString());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SMScode(),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> postCode(String code, BuildContext context) async {
    print('zavupa coda');
    try {
      final response = await dio.post('auth/verify-code', data: {"code": code});
      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData['token'];
        saveToken(token);
        setupInterceptors();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
        return token;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> setupInterceptors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(tokenKey);
    print('работает интерсептор');
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

  Future<bool> saveToken(String token) async {
    print('token na meste');
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
