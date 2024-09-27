import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/services/databaseService.dart';

class ListVSM with ChangeNotifier {
  List<Congviec> danhsach = [];
  var logger = Logger();
  Future themCongViec(Congviec congViec) async {
    logger.i("Cong viec : ${congViec.tieuDeCongViec}");
    danhsach.add(congViec);
    // lưu trong sqlite
    await DatabaseService.instance.create(congViec);
    notifyListeners();
  }

  Future capNhatCongViec(Congviec congViec) async {
    // danhsach[index] = congViec;
    await DatabaseService.instance.update(congViec);
    notifyListeners();
  }

  Future xoaCongViec(int id) async {
    await DatabaseService.instance.delete(id);
    notifyListeners();
  }

  Future check() async {
    logger.i("danh sach : ${danhsach.length}");
    notifyListeners();
  }
}
