import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzalif/data/models/comment.dart';
import 'package:tzalif/data/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  final int postId;
  CommentBloc({required this.commentRepository, required this.postId})
      : super(CommentInitial()) {
    on<FetchComment>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await commentRepository.getComment(postId);
        emit(CommentLoaded(comment: comments));
      } catch (e) {
        emit(CommentError(errorMessage: e.toString()));
      }
    });
  }
}
