import 'package:flutter/material.dart';
import 'package:my_crypto_app/features/crypto_list/widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Logic"),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, i) => Divider(
          color: theme.dividerColor,
        ),
        itemBuilder: (context, i) {
          const coinName = "Bitcoin";
          return CryptoCoinTile(
            coinName: coinName,
          );
        },
      ),
    );
  }
}
