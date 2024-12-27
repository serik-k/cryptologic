import 'package:dio/dio.dart';
import 'package:my_crypto_app/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final responce = await Dio().get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,LTC,XRP,ADA,DOGE,SOL,MATIC,LINK,SHIB,DOT,AVAX,UNI,TRX,BNB,FTM&tsyms=USD");
    final data = responce.data as Map<String, dynamic>;
    final dataRaw = data["RAW"] as Map<String, dynamic>;

    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      );
    }).toList();
    return cryptoCoinsList;
  }
}
