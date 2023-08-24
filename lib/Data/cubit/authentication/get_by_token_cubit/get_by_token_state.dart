import '../../../models/Auth_models/get_by_token_model.dart';

abstract class GetByTokenState {}

class GetByTokenInitial extends GetByTokenState {}

class GetByTokenLoading extends GetByTokenState {}

class GetByTokenLoaded extends GetByTokenState {
  GetByTokenModel? response;

  GetByTokenLoaded(this.response);
}

class GetByTokenError extends GetByTokenState {}
