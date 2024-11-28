import '../datasources/remote/api_service.dart';
import '../datasources/local/database_helper.dart';
import '../models/user.dart';

class UserRepository {
  final ApiService apiService;
  final DatabaseHelper databaseHelper;

  UserRepository({required this.apiService, required this.databaseHelper});

  Future<List<UsersModel>> getUser(int id) async {
    try {
      final user = await apiService.getUsers();
      await databaseHelper.insertUser(user);
      return user;
    } catch (e) {
      print('Error fetching user from API: $e');
      return await databaseHelper.getUsers();
    }
  }
}
