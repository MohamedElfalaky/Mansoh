import '../../../models/Auth_models/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryModel? response;

  CategoryLoaded(this.response);
}

class CategoryError extends CategoryState {}
