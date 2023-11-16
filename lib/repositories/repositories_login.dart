import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PhoneNumberCheker {
  final dio = Dio();
  PhoneNumberCheker(){
    dio.options.baseUrl = 'https://phystechlab.ru/rosseti/public/api/';
  }
  Future<void> postData(String data) async {
    print('zavupa pupa');
    try {
      final response = await dio.post(
          'auth/phone', data: data);
      if (response.statusCode == 200) {
        debugPrint(response.toString());
        final responseData = response.data;
        debugPrint(responseData.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
