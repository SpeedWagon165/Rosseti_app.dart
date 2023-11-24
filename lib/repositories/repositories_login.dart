import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosseti_project/SMS_code.dart';
import 'package:rosseti_project/mainpage.dart';

class PhoneNumberCheker {
  final Dio dio;

  PhoneNumberCheker() : dio = Dio() {
    print('Это конструктион');
    dio.options.baseUrl = 'https://phystechlab.ru/rosseti/public/api/';
  }

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
        setupInterceptors(token);
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

  void setupInterceptors(String? token) {
    print('работает инсектоид');
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
}

class SendSolution {
  final dioSolution = PhoneNumberCheker();
}
