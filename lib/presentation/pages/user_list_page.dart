import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzalif/core/repo_const.dart';
import 'package:tzalif/data/repositories/post_repository.dart';
import 'package:tzalif/presentation/bloc/post/post_bloc.dart';
import 'package:tzalif/presentation/pages/post_list_page.dart';
import 'package:tzalif/presentation/pages/user_adress_google_map.dart';
import '../bloc/user/user_bloc.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            BlocProvider.of<UserBloc>(context).add(FetchUsers());
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(user.name!),
                            subtitle: Text(user.email!),
                            onTap: () {
                              final repository = PostRepository(
                                  apiService: apiService,
                                  databaseHelper: localDatabaseService);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => PostBloc(
                                        postRepository: repository,
                                        postsId: user.id!),
                                    child: PostsList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserMap(
                                  location_user: user.address!.geo!,
                                );
                              }));
                            },
                            child: Container(
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Colors.greenAccent),
                              child: ListTile(
                                title: Text(
                                  "Адрес",
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
