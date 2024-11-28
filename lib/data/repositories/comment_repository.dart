import 'package:tzalif/data/models/comment.dart';

import '../datasources/remote/api_service.dart';
import '../datasources/local/database_helper.dart';

class CommentRepository {
  final ApiService apiService;
  final DatabaseHelper databaseHelper;

  CommentRepository({required this.apiService, required this.databaseHelper});

  Future<List<CommentModel>> getComment(int id) async {
    try {
      final post = await apiService.getComments(id);

      await databaseHelper.insertComment(post);
      return post;
    } catch (e) {
      print('Error fetching user from API: $e');
      return await databaseHelper.getComments();
    }
  }
}
