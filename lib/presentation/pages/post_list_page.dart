import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzalif/core/repo_const.dart';
import 'package:tzalif/data/repositories/comment_repository.dart';
import 'package:tzalif/presentation/bloc/comment/comment_bloc.dart';
import 'package:tzalif/presentation/bloc/post/post_bloc.dart';
import 'package:tzalif/presentation/pages/post_detail_page.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts List')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            BlocProvider.of<PostBloc>(context).add(FetchPosts());
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final user = state.posts[index];
                return Card(
                  child: ListTile(
                    title: Text(user.title!),
                    subtitle: Text(user.body!),
                    onTap: () {
                      final repository = CommentRepository(
                          apiService: apiService,
                          databaseHelper: localDatabaseService);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CommentBloc(
                                commentRepository: repository,
                                postId: user.id!),
                            child: CommentList(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return Container();
        },
      ),
    );
  }
}
