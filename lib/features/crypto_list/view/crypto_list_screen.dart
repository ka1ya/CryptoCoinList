import 'dart:async';

import 'package:crypto_coin_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coin_list/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_coin_list/repositoies/crypto_coins/crypto_coins.dart';
import 'package:crypto_coin_list/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepositories>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(ListCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(
            child: Text(
              'Crypto Currencies List',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(ListCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  itemCount: state.coinsList.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, i) {
                    final coin = state.coinsList[i];
                    return CryptoCoinTitle(coin: coin);
                  },
                );
              }
              if (state is CryptoListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Something goes wrong',
                        style: darkTheme.textTheme.labelSmall
                            ?.copyWith(fontSize: 20),
                      ),
                      Text(
                        'Please try again later',
                        style: darkTheme.textTheme.labelSmall
                            ?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          _cryptoListBloc.add(ListCryptoList());
                        },
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
