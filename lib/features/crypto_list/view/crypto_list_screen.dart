import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_crypto_app/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:my_crypto_app/features/crypto_list/widgets/widgets.dart';
import 'package:my_crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc =
      CryptoListBloc(GetIt.I<AbstractCryptoCoinsRepository>());

  @override
  void initState() {
    super.initState();
    _cryptoListBloc.add(LoadCryptoList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Crypto Logic"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: state.coinList.length,
                  separatorBuilder: (context, i) => Divider(
                    color: theme.dividerColor,
                  ),
                  itemBuilder: (context, i) {
                    final coin = state.coinList[i];
                    return CryptoCoinTile(
                      coin: coin,
                    );
                  },
                );
              }
              if (state is CryptoListError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Something went wrong",
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text("Please try again",
                        style:
                            theme.textTheme.labelSmall?.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          _cryptoListBloc.add(LoadCryptoList());
                        },
                        child: Text("Try Again",
                            style: theme.textTheme.labelSmall))
                  ],
                ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
