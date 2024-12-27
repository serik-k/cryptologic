import 'package:flutter/material.dart';
import 'package:my_crypto_app/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(coin.imageUrl),
      title: Text(coin.name, style: theme.textTheme.bodyMedium),
      subtitle: Text('${coin.priceInUSD.toStringAsFixed(5)} \$',
          style: theme.textTheme.labelSmall),
      trailing: Icon(
        Icons.arrow_forward_ios,
      ),
      onTap: () {
        Navigator.of(context).pushNamed("/coin", arguments: coin.name);
      },
    );
  }
}
