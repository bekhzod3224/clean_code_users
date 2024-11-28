import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzalif/data/models/post.dart';
import 'package:tzalif/data/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final int postsId;
  PostBloc({ required this.postsId, required this.postRepository})
      : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await postRepository.getPost(postsId);
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
