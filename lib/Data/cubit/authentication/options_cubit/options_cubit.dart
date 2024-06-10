import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/options_repo/options_repo.dart';
import 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit() : super(OptionsInitial());
  OptionsRepo optionsRepo = OptionsRepo();

  getOptions() async {
    try {
      emit(OptionsLoading());
      final mList = await optionsRepo.getOptions();
      emit(OptionsLoaded(mList));
    } catch (e) {
      emit(OptionsError());
    }
  }
}
