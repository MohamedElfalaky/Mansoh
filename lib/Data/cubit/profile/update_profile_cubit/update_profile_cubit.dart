import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/Home/Home.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/profile_repos/update_profile_repo.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());
  UpdateProfile updateProfile = UpdateProfile();

  updateMethod({
    String? email,
    String? fullName,
    String? mobile,
    String? countryId,
    String? cityId,
    String? gender,
    String? nationalityId,
    String? avatar,
    BuildContext? context,
  }) {
    try {
      emit(UpdateProfileLoading());
      updateProfile
          .update(
        avatar: avatar,
        email: email,
        fullName: fullName,
        gender: gender,
        mobile: mobile,
        nationalityId: nationalityId,
        cityId: cityId,
        countryId: countryId,
      )
          .then((value) {
        if (value != null) {
          emit(UpdateProfileLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(context!, Home());
        } else {
          emit(UpdateProfileError());
        }
      });
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(UpdateProfileError());
    }
  }
}
