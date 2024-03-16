import 'package:nasooh/Data/models/coupons_model.dart';

abstract class CouponsState {}

class CouponsInitial extends CouponsState {}

class CouponsLoading extends CouponsState {}

class CouponsDone extends CouponsState {
  CouponsModel couponsModel;
  CouponsDone(this.couponsModel);
}

class CouponsError extends CouponsState {}
