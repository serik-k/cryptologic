import 'package:flutter/material.dart';
import 'package:my_crypto_app/router/router.dart';
import 'package:my_crypto_app/theme/theme.dart';

class MyCryptoApp extends StatelessWidget {
  const MyCryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto logic',
      theme: darkTheme,
      routes: routes,
    );
  }
}
