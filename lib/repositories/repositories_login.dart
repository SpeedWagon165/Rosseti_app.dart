import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CryptoCoinsRepository {
  final dio = Dio();

  Future<void> getCoinList() async {
    print('zavupa pupa');
    try {
      final response = await dio.get(
          'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,EUR');
      debugPrint(response.toString());
    } catch (e) {
      print(e);
    }
  }
}
