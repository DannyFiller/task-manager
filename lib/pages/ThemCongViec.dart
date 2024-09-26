import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/services/databaseService.dart';
import 'package:task_manager/trangchu.dart';

class ThemCongViec extends StatefulWidget {
  const ThemCongViec({super.key});

  @override
  State<ThemCongViec> createState() => _ThemCongViecState();
}

class _ThemCongViecState extends State<ThemCongViec> {
  final List<String> items = [
    'Online',
    'Offline',
  ];
  var logger = Logger();
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 7, minute: 0);

  final TextEditingController _tieuDeController = TextEditingController();
  final TextEditingController _noiDungController = TextEditingController();
  final TextEditingController _ngaylamController = TextEditingController();
  final TextEditingController _thoiGianController = TextEditingController();
  final TextEditingController _diaDiemController = TextEditingController();
  final TextEditingController _ghiChuController = TextEditingController();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          setState(() {
            _timeOfDay = value;
            _thoiGianController.text = _timeOfDay.format(context);
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
        _ngaylamController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        logger.i(_ngaylamController.text);
      });
    }
  }

  Future<void> _themCongViec() async {
    Congviec congviec = Congviec(
        tieuDeCongViec: _tieuDeController.text,
        noiDung: _noiDungController.text,
        ngayLamViec: DateFormat('dd-MM-yyyy').parse(_ngaylamController.text),
        thoiGianLamViec: _timeOfDay,
        diaDiem: _diaDiemController.text,
        ghiChu: _ghiChuController.text,
        trangThai: false);
    Provider.of<ListVSM>(context, listen: false).themCongViec(congviec);
    Provider.of<ListVSM>(context, listen: false).check();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TrangChu(),
        ));

    // logger.i("${congviec.NgayLamViec} | ${congviec.ThoiGianLamViec}");
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm Công Việc"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _tieuDeController,
                    decoration: const InputDecoration(
                      label: Text("Tiêu đề công việc"),
                      prefixIcon: Icon(Icons.title_outlined),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _noiDungController,
                    decoration: const InputDecoration(
                      label: Text("Nội dung công việc"),
                      prefixIcon: Icon(Icons.subtitles_outlined),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    onTap: () {
                      _selectDate(context);
                    },
                    controller: _ngaylamController,
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
                    controller: _thoiGianController,
                    onTap: () {
                      _showTimePicker();
                    },
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
                      prefixIcon: const Icon(Icons.person),
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Địa Điểm',
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
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _ghiChuController,
                    decoration: const InputDecoration(
                      label: Text("Ghi chú"),
                      prefixIcon: Icon(Icons.note_add_outlined),
                      enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _themCongViec();
                  },
                  child: Container(
                    height: 60,
                    // width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Lưu Công Việc",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
