import '../../../models/category_parent_model.dart';

abstract class CategoryParentState {}

class CategoryParentInitial extends CategoryParentState {}

class CategoryParentLoading extends CategoryParentState {}

class CategoryParentLoaded extends CategoryParentState {
  CategoryParentModel? response;

  CategoryParentLoaded(this.response);
}

class CategoryParentError extends CategoryParentState {}
