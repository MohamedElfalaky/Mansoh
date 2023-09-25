import '../../../models/rejection_models/list_rejection_model.dart';

abstract class ListRejectionState {}

class ListRejectionInitial extends ListRejectionState {}

class ListRejectionLoading extends ListRejectionState {}

class ListRejectionLoaded extends ListRejectionState {
  ListRejectionModel? response;

  ListRejectionLoaded(this.response);
}

class ListRejectionError extends ListRejectionState {}
