import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tzalif/core/repo_const.dart';
import 'package:tzalif/data/repositories/user_repository.dart';
import 'package:tzalif/presentation/bloc/user/user_bloc.dart';
import 'package:tzalif/presentation/pages/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = UserRepository(
      apiService: apiService, databaseHelper: localDatabaseService);

  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository repository;
  const MyApp({super.key, required this.repository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => UserBloc(userRepository: repository),
          child: UserList()),
    );
  }
}
