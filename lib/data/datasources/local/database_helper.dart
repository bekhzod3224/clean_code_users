import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/user.dart';
import '../../models/post.dart';
import '../../models/comment.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    await deleteDatabase(path);
    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phone TEXT,
        website TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT,
        body TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE comments(
        id INTEGER PRIMARY KEY,
        postId INTEGER,
        name TEXT,
        email TEXT,
        body TEXT
      )
    ''');
  }

  Future<void> insertUser(List<UsersModel> users) async {
    final db = await database;

    for (var user in users) {
      await db.insert(
        'users',
        user.toJson(), 
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertPost(List<PostsModel> posts) async {
    final db = await database;

    for (var post in posts) {
      await db.insert(
        'posts',
        post.toJson(), 
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertComment(List<CommentModel> comments) async {
    final db = await database;

    for (var comment in comments) {
      await db.insert(
        'comments',
        comment.toJson(), 
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<UsersModel>> getUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UsersModel.fromJson(maps[i]);
    });
  }

  Future<List<PostsModel>> getPosts() async {
    final db = await database;
    final maps = await db.query('posts');
    return List.generate(maps.length, (i) {
      return PostsModel.fromJson((maps[i]));
    });
  }

  Future<List<CommentModel>> getComments() async {
    final db = await database;
    final maps = await db.query('comments');
    return List.generate(maps.length, (i) {
      return CommentModel.fromJson((maps[i]));
    });
  }

}
