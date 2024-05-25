import '../../../models/settings_models/about_us_model.dart';

abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  AboutUsModel? response;

  AboutLoaded(this.response);
}

class AboutError extends AboutState {}
