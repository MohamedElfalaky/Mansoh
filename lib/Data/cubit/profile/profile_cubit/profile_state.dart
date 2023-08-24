import '../../../models/profile_models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileModel? response;

  ProfileLoaded(this.response);
}

class ProfileError extends ProfileState {}
