part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> comment;
  CommentLoaded({required this.comment});
}

class CommentError extends CommentState {
  final String errorMessage;
  CommentError({required this.errorMessage});
}
