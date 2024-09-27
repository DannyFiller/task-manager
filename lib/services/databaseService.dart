import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_manager/models/congViec.dart';
import 'dart:io';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('congviec.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const dateType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE CongViec (
      id $idType,
      tieuDeCongViec $textType, 
      noiDung $textType,
      ngayLamViec $dateType,
      thoiGianLamViec $textType,
      diaDiem $textType,
      ghiChu $textType,
      trangThai $boolType
    )
    ''');
  }

  // Thêm công việc
  Future<int> create(Congviec congviec) async {
    final db = await instance.database;
    return await db.insert('CongViec', congviec.toMap());
  }

  // Lấy tất cả công việc
  Future<List<Congviec>> readAllCongviec() async {
    final db = await instance.database;

    final result = await db.query('CongViec');

    return result.map((json) => Congviec.fromMap(json)).toList();
  }

  Future<List<Congviec>> readAllCongviecChuaHoanThanh() async {
    final db = await instance.database;

    final result = await db.query(
      'CongViec',
      where: 'trangThai = ?',
      whereArgs: [0],
    );

    return result.map((json) => Congviec.fromMap(json)).toList();
  }

  // Cập nhật công việc
  Future<int> update(Congviec congviec) async {
    final db = await instance.database;

    return db.update(
      'CongViec',
      congviec.toMap(),
      where: 'id = ?',
      whereArgs: [congviec.id],
    );
  }

  // Xóa công việc
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'CongViec',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Đóng database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
