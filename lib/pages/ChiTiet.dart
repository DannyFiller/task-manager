import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/trangchu.dart';

class ChiTiet extends StatefulWidget {
  final Congviec congviec;
  final int index;
  ChiTiet({Key? key, required this.congviec, required this.index})
      : super(key: key);

  @override
  State<ChiTiet> createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  String? selectedValue;
  final List<String> items = [
    'Chưa hoàn thành',
    'Đã hoàn thành',
  ];

  String? tinhTrang;
  var logger = Logger();
  final TextEditingController _ngayLamController = TextEditingController(
    text: "Ngày làm việc",
  );
  final TextEditingController _thoiGianController = TextEditingController(
    text: "Thời gian làm việc",
  );
  final TextEditingController _tieuDeController = TextEditingController(
    text: "Tiêu Đề",
  );
  final TextEditingController _noiDungController = TextEditingController(
    text: "Nội Dung",
  );
  final TextEditingController _ghiChuController = TextEditingController(
    text: "Ghi Chú",
  );
  bool? luuTinhTrang;
  DateTime? ngayLam;
  TimeOfDay? thoiGianLam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tieuDeController.text = widget.congviec.tieuDeCongViec.toString();
    logger.i(widget.congviec.tieuDeCongViec);
    _noiDungController.text = widget.congviec.noiDung.toString();
    _ghiChuController.text = widget.congviec.ghiChu.toString();
    _ngayLamController.text =
        DateFormat('dd-MM-yyyy').format(widget.congviec.ngayLamViec!);
    if (widget.congviec.trangThai == false) {
      tinhTrang = "Chưa hoàn thành";
      luuTinhTrang = false;
    } else {
      tinhTrang = "Đã hoàn thành";
      luuTinhTrang = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //tạo thời gian sau khi khởi tạo xong các widget và context
    _thoiGianController.text = widget.congviec.thoiGianLamViec!.format(context);
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          setState(() {
            widget.congviec.thoiGianLamViec = value;
            _thoiGianController.text =
                widget.congviec.thoiGianLamViec!.format(context);
            ;
          });
        }
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _ngayLamController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        logger.i(_ngayLamController.text);
      });
    }
  }

  void capNhat() {
    Congviec congviec = Congviec(
      id: widget.congviec.id,
      tieuDeCongViec: _tieuDeController.text,
      noiDung: _noiDungController.text,
      ngayLamViec: DateFormat('dd-MM-yyyy').parse(_ngayLamController.text),
      thoiGianLamViec: widget.congviec.thoiGianLamViec,
      trangThai: luuTinhTrang,
      diaDiem: widget.congviec.diaDiem,
      ghiChu: _ghiChuController.text,
    );
    Provider.of<ListVSM>(context, listen: false).capNhatCongViec(congviec);
    logger.i(congviec.tieuDeCongViec);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TrangChu(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Công việc"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                onTap: () => _selectDate(context),
                controller: _ngayLamController,
                decoration: const InputDecoration(
                  label: Text("Ngày làm việc"),
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                readOnly: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                onTap: () => _showTimePicker(),
                controller: _thoiGianController,
                decoration: const InputDecoration(
                  label: Text("Thời gian làm việc"),
                  prefixIcon: Icon(Icons.timelapse_outlined),
                  enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                readOnly: true,
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  prefixIcon: const Icon(Icons.bar_chart),
                ),
                isExpanded: true,
                hint: Text(
                  tinhTrang!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                    if (value == "Đã hoàn thành") {
                      luuTinhTrang = true;
                    } else {
                      luuTinhTrang = false;
                    }
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _tieuDeController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  prefix: Text(
                    "Tiêu đề: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _ghiChuController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  prefix: Text(
                    "Ghi Chú: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _noiDungController,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                capNhat();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                // color: Colors.white,
                height: 60,
                margin: const EdgeInsets.only(bottom: 16),
                // width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Lưu Công Việc",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
