import '../../../models/Auth_models/check_mobile_model.dart';

abstract class MobState {}

class MobInitial extends MobState {}

class MobLoading extends MobState {}

class MobLoaded extends MobState {
  MobModel? response;

  MobLoaded(this.response);
}

class MobError extends MobState {}
