import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/coupons_cubit/coupons_state.dart';
import 'package:nasooh/Data/models/coupons_model.dart';
import '../../repositories/wallet_repo/wallet_repo.dart';

class CouponsCubit extends Cubit<CouponsState> {
  CouponsCubit() : super(CouponsInitial());
  WalletRepo walletRepo = WalletRepo();

  getPromoCodes() async {
    emit(CouponsLoading());

    CouponsModel? couponsModel = await walletRepo.getPromoCodes();
    print('promo codes length');
    print(couponsModel?.data?.length);
    if (couponsModel?.status == 1) {
      emit(CouponsDone(couponsModel!));
    } else {
      emit(CouponsError());
    }
  }
}
