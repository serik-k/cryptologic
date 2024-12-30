part of 'crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({required this.coinList});
  final List<CryptoCoin> coinList;

  @override
  List<Object?> get props => [coinList];
}

class CryptoListError extends CryptoListState {
  CryptoListError({this.error});
  final Object? error;

  @override
  List<Object?> get props => [error];
}
