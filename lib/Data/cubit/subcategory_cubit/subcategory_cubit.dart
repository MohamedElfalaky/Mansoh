import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/subcategory_cubit/subcategory_state.dart';

import '../../../app/keys.dart';
import '../../../app/utils/exports.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/orders_models/subcategory_model.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitial());
  SubCategoryModel? subCategoryModel;

  Future<void> getSubCategory(id) async {
    emit(SubCategoryLoading());
    http.Response response = await http.get(
      Uri.parse('${Keys.baseUrl}/adviser/coredata/category/list?parent_id=$id'),
      headers: {
        'Accept': 'application/json',
        'lang': "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      },
    );
    Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200 && responseMap["status"] == 1) {
      debugPrint(responseMap.toString());
      subCategoryModel = SubCategoryModel.fromJson(responseMap);
      debugPrint("sub category orders  ${subCategoryModel?.data}");
      emit(SubCategoryDone());
    } else {
      MyApplication.showToastView(message: responseMap["message"]);
      emit(SubCategoryError());
    }
  }
}
