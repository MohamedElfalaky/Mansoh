import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/get_by_token_repo.dart';
import 'get_by_token_state.dart';

class GetByTokenCubit extends Cubit<GetByTokenState> {
  GetByTokenCubit() : super(GetByTokenInitial());
  GetByTokenRepo profileRepo = GetByTokenRepo();

  getDataGetByToken() async {
    try {
      emit(GetByTokenLoading());
      final mList = await profileRepo.getGetByToken();
      emit(GetByTokenLoaded(mList));
    } catch (e) {
      emit(GetByTokenError());
    }
  }
}
