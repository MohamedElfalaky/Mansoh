
import '../../models/advisor_profile_model/advisor_profile.dart';

abstract class AdvisorProfileState {}

class AdvisorProfileInitial extends AdvisorProfileState {}

class AdvisorProfileLoading extends AdvisorProfileState {}

class AdvisorProfileLoaded extends AdvisorProfileState {
  AdvisorProfileModel? response;

  AdvisorProfileLoaded(this.response);
}

class AdvisorProfileError extends AdvisorProfileState {}
