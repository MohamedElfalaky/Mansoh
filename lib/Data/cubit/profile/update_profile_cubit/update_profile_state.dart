import '../../../models/profile_models/update_profile_model.dart';

abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileLoaded extends UpdateProfileState {
  UpdateProfileModel? response;

  UpdateProfileLoaded(this.response);
}

class UpdateProfileError extends UpdateProfileState {}
