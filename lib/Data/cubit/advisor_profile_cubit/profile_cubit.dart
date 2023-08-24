import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/advisor_profile_repo/advisor_profile_repo.dart';
import 'profile_state.dart';

class AdvisorProfileCubit extends Cubit<AdvisorProfileState> {
  AdvisorProfileCubit() : super(AdvisorProfileInitial());
  AdvisorProfileRepo profileRepo = AdvisorProfileRepo();

  getDataAdvisorProfile(int id) async {
    try {
      emit(AdvisorProfileLoading());
      final mList = await profileRepo.getProfile(id);
      emit(AdvisorProfileLoaded(mList));
    } catch (e) {
      emit(AdvisorProfileError());
    }
  }
}
