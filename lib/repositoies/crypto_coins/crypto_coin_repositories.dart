import 'package:crypto_coin_list/repositoies/crypto_coins/models/crypto_coin.dart';
import 'package:dio/dio.dart';

class CryptoCoinRepository {
  Future<List<CryptoCoin>> getCoinList() async {
    final response = await Dio().get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,USDT,SOL,DOGE,MATIC,LTC,XRP,DAI,TRX&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = response.data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/${imageUrl}',
      );
    }).toList();
    return cryptoCoinsList;
  }
}
