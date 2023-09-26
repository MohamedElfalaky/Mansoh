import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/authentication/category_parent_cubit/category_parent_state.dart';
import '../../../models/Auth_models/category_model.dart';
import '../../../repositories/authentication/category_repo/category_parent_repo.dart';

class CategoryParentCubit extends Cubit<CategoryParentState> {
  CategoryParentCubit() : super(CategoryParentInitial());
  CategoryParentRepo categoryRepo = CategoryParentRepo();

  CategoryModel? categoryModel;


  getCategoryParent() async {
    try {
      emit(CategoryParentLoading());
      final mList = await categoryRepo.getData();
      categoryModel = mList;
      emit(CategoryParentLoaded(mList));
      // } else {
      //   emit(CategoryParentError());
      // }
    } catch (e) {
      emit(CategoryParentError());
    }
  }
}