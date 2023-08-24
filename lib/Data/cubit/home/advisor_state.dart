import '../../models/home_models/advisor_list_model.dart';

abstract class AdvisorState{}


class AdvisorListInitial extends AdvisorState {}

class AdvisorListLoading extends AdvisorState {}

class AdvisorListLoaded extends AdvisorState {
  AdvisorListModel? adListResponse;

  AdvisorListLoaded(this.adListResponse);
}

class AdvisorListError extends AdvisorState {}