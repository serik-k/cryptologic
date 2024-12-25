import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coinName,
  });

  final String coinName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(
        "assets/svg/bitcoin-logo.svg",
        height: 35,
        width: 35,
      ),
      title: Text(coinName, style: theme.textTheme.bodyMedium),
      subtitle: Text("100 000\$", style: theme.textTheme.labelSmall),
      trailing: Icon(
        Icons.arrow_forward_ios,
      ),
      onTap: () {
        Navigator.of(context).pushNamed("/coin", arguments: coinName);
      },
    );
  }
}
