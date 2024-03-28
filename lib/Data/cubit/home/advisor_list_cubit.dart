import 'package:nasooh/Data/cubit/home/advisor_state.dart';

import '../../../app/utils/exports.dart';
import '../../repositories/home_repos/advisor_list_repo.dart';

class AdvisorListCubit extends Cubit<AdvisorState> {
  AdvisorListCubit() : super(AdvisorListInitial());

  AdvisorListRepo advisorListRepo = AdvisorListRepo();

  Future<void> getAdvisorList(
      {String? categoryValue, String? searchTxt, dynamic rateVal}) async {
    try {
      emit(AdvisorListLoading());
      final advisorList = await advisorListRepo.getAdvisorList(
          catVal: categoryValue, searchTxt: searchTxt, rateVal: rateVal);
      debugPrint('ADVISOR LIST ${advisorList?.data?.length}');

      if (advisorList?.data?.isEmpty == true) {
        emit(AdvisorListEmpty());
      } else {
        emit(AdvisorListLoaded(advisorList));
      }
    } catch (e) {
      emit(AdvisorListError());
    }
  }
}
