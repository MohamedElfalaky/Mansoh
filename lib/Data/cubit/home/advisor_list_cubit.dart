import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/home/advisor_state.dart';
import '../../repositories/home_repos/advisor_list_repo.dart';

class AdvisorListCubit extends Cubit<AdvisorState> {
  AdvisorListCubit() : super(AdvisorListInitial());


  AdvisorListRepo advisorListRepo = AdvisorListRepo();

  getAdvisorList() async {
    try {
      emit(AdvisorListLoading());
      final mList = await advisorListRepo.getAdList();
      emit(AdvisorListLoaded(mList));
    } catch (e) {
      emit(AdvisorListError());
    }
  }
}