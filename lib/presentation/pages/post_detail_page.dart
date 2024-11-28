import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzalif/presentation/bloc/comment/comment_bloc.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment List'),
      ),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentInitial) {
            BlocProvider.of<CommentBloc>(context).add(FetchComment());
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentLoaded) {
            return ListView.builder(
              itemCount: state.comment.length,
              itemBuilder: (context, index) {
                final user = state.comment[index];
                return Card(
                  child: ListTile(
                    title: Text(user.name!),
                    subtitle: Text(user.body!),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => UserDetailPage(user: user),
                      //   ),
                      // );
                    },
                  ),
                );
              },
            );
          } else if (state is CommentError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return Container();
        },
      ),
    );
  }
}
