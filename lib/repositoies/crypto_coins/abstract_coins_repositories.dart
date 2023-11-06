import 'package:crypto_coin_list/repositoies/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCoinsRepositories {
  Future<List<CryptoCoin>> getCoinList();
}
