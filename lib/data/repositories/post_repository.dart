import 'package:tzalif/data/models/post.dart';

import '../datasources/remote/api_service.dart';
import '../datasources/local/database_helper.dart';

class PostRepository {
  final ApiService apiService;
  final DatabaseHelper databaseHelper;

  PostRepository({required this.apiService, required this.databaseHelper});

  Future<List<PostsModel>> getPost(int id) async {
    try {
      final post = await apiService.getPosts(id);

      await databaseHelper.insertPost(post);
      return post;
    } catch (e) {
      print('Error fetching user from API: $e');
      return await databaseHelper.getPosts();
    }
  }
}
