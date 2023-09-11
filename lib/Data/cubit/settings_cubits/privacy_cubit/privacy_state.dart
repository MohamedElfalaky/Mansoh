
import 'package:nasooh/Data/models/settings_models/privacy_policy_model.dart';

abstract class PrivacyState {}

class PrivacyInitial extends PrivacyState {}

class PrivacyLoading extends PrivacyState {}

class PrivacyLoaded extends PrivacyState {
  PrivacyPolicyModel? response;

  PrivacyLoaded(this.response);
}

class PrivacyError extends PrivacyState {}
