import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_crypto_app/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:my_crypto_app/repositories/crypto_coins/models/crypto_coin.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }
        final coinList = await coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinList: coinList));
      } catch (e) {
        emit(CryptoListError(error: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCryptoCoinsRepository coinsRepository;
}
