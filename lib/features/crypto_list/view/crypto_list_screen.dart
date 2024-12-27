import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:my_crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:my_crypto_app/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    super.initState();
    _loadCryptoCoins();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Logic"),
      ),
      body: _cryptoCoinsList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: _cryptoCoinsList!.length,
              separatorBuilder: (context, i) => Divider(
                color: theme.dividerColor,
              ),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];
                return CryptoCoinTile(
                  coin: coin,
                );
              },
            ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList =
        await GetIt.I<AbstractCryptoCoinsRepository>().getCoinsList();
    setState(() {});
  }
}
