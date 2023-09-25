import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/Rejections_repo/post_reject_repo.dart';
import 'post_reject_state.dart';

class PostRejectCubit extends Cubit<PostRejectState> {
  PostRejectCubit() : super(PostRejectInitial());
  PostRejectRepo doneAdviceRepo = PostRejectRepo();

  postRejectMethod({
    String? commentId,
    String? commentOther,
    required String adviceId,
  }) async {
    try {
      emit(PostRejectLoading());
      final mList = await doneAdviceRepo.reject(
          commentId: commentId, commentOther: commentOther, adviceId: adviceId);
      emit(PostRejectLoaded(mList));
    } catch (e) {
      emit(PostRejectError());
    }
  }
}
