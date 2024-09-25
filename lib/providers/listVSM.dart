import 'package:flutter/material.dart';
import 'package:task_manager/models/CongViec.dart';
import 'package:logger/logger.dart';

class ListVSM with ChangeNotifier {
  // Account? currentAcc;

  // Future setCurrentAcc(String email) async {
  //   ApiService apiService = ApiService();
  //   currentAcc = await apiService.getAccount(email);
  //   notifyListeners();
  // }

  // updateCurrentAcc() async {
  //   ApiService apiService = ApiService();
  //   await apiService.updateAccount(currentAcc!);
  //   notifyListeners();
  // }

  // setImage(String img) {
  //   currentAcc!.setImage(img);
  //   notifyListeners();
  // }
  List<Congviec> danhsach = [];
  var logger = Logger();
  Future themCongViec(Congviec congViec) async {
    logger.i("Cong viec : ${congViec.tieuDeCongViec}");
    danhsach.add(congViec);
    notifyListeners();
  }

  Future xoaCongViec(int index) async {
    danhsach.removeAt(index);
    logger.i("danh sach : ${danhsach.length}");
    notifyListeners();
  }

  Future check() async {
    logger.i("danh sach : ${danhsach.length}");
    notifyListeners();
  }
}
