import 'package:my_crypto_app/repositories/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
}
