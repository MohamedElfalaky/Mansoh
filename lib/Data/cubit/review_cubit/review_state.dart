import '../../models/rejection_models/post_reject_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  PostRejectModel? response;

  ReviewLoaded(this.response);
}

class ReviewError extends ReviewState {}
