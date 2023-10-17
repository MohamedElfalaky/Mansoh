import '../../models/wallet_models/wallet_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  WalletData? response;

  WalletLoaded(this.response);
}

class WalletError extends WalletState {}
