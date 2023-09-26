import '../../../models/Auth_models/category_model.dart';

abstract class CategoryParentState {}

class CategoryParentInitial extends CategoryParentState {}

class CategoryParentLoading extends CategoryParentState {}

class CategoryParentLoaded extends CategoryParentState {
  CategoryModel? response;

  CategoryParentLoaded(this.response);
}

class CategoryParentError extends CategoryParentState {}
