import 'package:flutter/material.dart';

class Congviec {
  int? id;
  String? tieuDeCongViec;
  String? noiDung;
  DateTime? ngayLamViec;
  TimeOfDay? thoiGianLamViec;
  String? diaDiem;
  String? ghiChu;
  bool? trangThai;

  // Congviec(
  //     {this.tieuDeCongViec,
  //     this.noiDung,
  //     this.ngayLamViec,
  //     this.thoiGianLamViec,
  //     this.diaDiem,
  //     this.ghiChu,
  //     this.trangThai});
  Congviec(
      {this.id,
      this.tieuDeCongViec,
      this.noiDung,
      this.ngayLamViec,
      this.thoiGianLamViec,
      this.diaDiem,
      this.ghiChu,
      this.trangThai});

  setTieuDeCongViec(String tieuDe) {
    this.tieuDeCongViec = tieuDe;
  }

  setnoiDung(String noiDung) {
    this.noiDung = noiDung;
  }

  setNgayLamViec(DateTime ngayLamViec) {
    this.ngayLamViec = ngayLamViec;
  }

  setThoiGian(TimeOfDay thoiGianLamViec) {
    this.thoiGianLamViec = thoiGianLamViec;
  }

  setDiaDiem(String diaDiem) {
    this.diaDiem = diaDiem;
  }

  setGhiChu(String ghiChu) {
    this.ghiChu = ghiChu;
  }

  factory Congviec.fromMap(Map<String, dynamic> json) => Congviec(
        id: json['id'],
        tieuDeCongViec: json['tieuDeCongViec'],
        noiDung: json['noiDung'],
        ngayLamViec: DateTime.parse(json['ngayLamViec']),
        thoiGianLamViec: TimeOfDay(
            hour: int.parse(json['thoiGianLamViec'].split(":")[0]),
            minute: int.parse(json['thoiGianLamViec'].split(":")[1])),
        diaDiem: json['diaDiem'],
        ghiChu: json['ghiChu'],
        trangThai: json['trangThai'] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() {
    return {
      'tieuDeCongViec': tieuDeCongViec,
      'noiDung': noiDung,
      'ngayLamViec': ngayLamViec!.toIso8601String(),
      'thoiGianLamViec':
          '${thoiGianLamViec!.hour}:${thoiGianLamViec!.minute}', // Lưu thành chuỗi
      'diaDiem': diaDiem,
      'ghiChu': ghiChu,
      'trangThai': trangThai == true ? 1 : 0, // Lưu dưới dạng int
    };
  }
}
