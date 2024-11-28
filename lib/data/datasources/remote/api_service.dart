import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../../models/post.dart';
import '../../models/comment.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UsersModel>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => UsersModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<PostsModel>> getPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/posts'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => PostsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => CommentModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
