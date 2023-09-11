import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/settings/privacy_policy_repo.dart';
import 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit() : super(PrivacyInitial());
  PolicyRepo privacyRepo = PolicyRepo();


  getPrivacy() async {
    try {
      emit(PrivacyLoading());
      final mList = await privacyRepo.getPolicy();
      emit(PrivacyLoaded(mList));
    } catch (e) {
      emit(PrivacyError());
    }
  }
}
