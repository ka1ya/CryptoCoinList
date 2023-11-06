import 'package:crypto_coin_list/crypto_currencies_list_app.dart';
import 'package:crypto_coin_list/repositoies/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepositories>(
    () => CryptoCoinRepository(dio: Dio()),
  );
  runApp(const CryptoCurrenciesListApp());
}
