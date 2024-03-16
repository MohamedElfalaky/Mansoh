import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_state.dart';

import '../../../models/rejection_models/list_rejection_model.dart';
import '../../../repositories/Rejections_repo/rejection_list_repo.dart';

class ListRejectionCubit extends Cubit<ListRejectionState> {
  ListRejectionCubit() : super(ListRejectionInitial());
  ListRejectionRepo listRejectionRepo = ListRejectionRepo();

  ListRejectionModel? profileModel;

  getDataListRejection() async {
    try {
      emit(ListRejectionLoading());
      final mList = await listRejectionRepo.getData();
      profileModel = mList;
      emit(ListRejectionLoaded(mList));
    } catch (e) {
      emit(ListRejectionError());
    }
  }
}
