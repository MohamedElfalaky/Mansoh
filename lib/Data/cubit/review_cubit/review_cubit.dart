import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/review_cubit/review_state.dart';
import '../../../Presentation/screens/Home/Home.dart';
import '../../../Presentation/widgets/alerts.dart';
import '../../../app/utils/myApplication.dart';
import '../../repositories/review_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  ReviewRepo reviewRepo = ReviewRepo();

  reviewMethod({
    String? speed,
    String? quality,
    String? flexibility,
    String? other,
    int? adviser,
    int? adviceId,
    int? app,
    BuildContext? context,
  }) {
    try {
      emit(ReviewLoading());
      reviewRepo
          .review(adviceId:adviceId ,
              adviser:adviser ,
              app:app ,
              flexibility:flexibility ,
              other:other ,
              quality:quality ,
              speed:speed ,
              )
          .then((value) {
        if (value != null) {
          emit(ReviewLoaded(value));
          Alert.alert(
              context: context,
              action: () {
                MyApplication.navigateToReplaceAllPrevious(context!,  Home(currentIndex: 0));
              },
              content: "تم ارسال تقييمك بنجاح",
              titleAction: "الرئيسية");
        } else {
          emit(ReviewError());
        }
      });
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(ReviewError());
    }
  }
}
