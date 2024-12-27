import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_crypto_app/my_crypto_app.dart';
import 'package:my_crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:my_crypto_app/repositories/crypto_coins/crypto_coins_repository.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCryptoCoinsRepository>(
      () => CryptoCoinsRepository(dio: Dio()));
  runApp(const MyCryptoApp());
}
