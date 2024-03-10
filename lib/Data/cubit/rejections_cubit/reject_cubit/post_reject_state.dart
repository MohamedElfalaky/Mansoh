import '../../../models/rejection_models/post_reject_model.dart';

abstract class PostRejectState {}

class PostRejectInitial extends PostRejectState {}

class PostRejectLoading extends PostRejectState {}

class PostRejectLoaded extends PostRejectState {
  PostRejectModel? response;

  PostRejectLoaded(this.response);
}

class PostRejectError extends PostRejectState {}
