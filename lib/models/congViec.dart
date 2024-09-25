// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Congviec {
  String? tieuDeCongViec;
  String? noiDung;
  DateTime? ngayLamViec;
  TimeOfDay? thoiGianLamViec;
  String? diaDiem;
  String? ghiChu;

  Congviec({
    this.tieuDeCongViec,
    this.noiDung,
    this.ngayLamViec,
    this.thoiGianLamViec,
    this.diaDiem,
    this.ghiChu,
  });
}
