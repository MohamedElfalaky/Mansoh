import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Auth_models/category_model.dart';
import '../../../repositories/authentication/category_repo/category_repo.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CategoryRepo categoryRepo = CategoryRepo();

  CategoryModel? categoryModel;

  static CategoryCubit get(context) => BlocProvider.of(context);

  getCategories() async {
    try {
      emit(CategoryLoading());
      final mList = await categoryRepo.getData();
      categoryModel = mList;
      emit(CategoryLoaded(mList));
      // } else {
      //   emit(CategoryError());
      // }
    } catch (e) {
      emit(CategoryError());
    }
  }
}
