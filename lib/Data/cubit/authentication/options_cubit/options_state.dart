import 'package:nasooh/Data/models/Auth_models/options_model.dart';

abstract class OptionsState {}

class OptionsInitial extends OptionsState {}

class OptionsLoading extends OptionsState {}

class OptionsLoaded extends OptionsState {
  OptionsModel? response;

  OptionsLoaded(this.response);
}

class OptionsError extends OptionsState {}
