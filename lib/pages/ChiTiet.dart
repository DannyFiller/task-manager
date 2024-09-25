import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';

class ChiTiet extends StatefulWidget {
  // final Congviec congviec;

  const ChiTiet({super.key});
  @override
  State<ChiTiet> createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  TextEditingController _tieuDeController = TextEditingController(
    text: "Tiêu Đề",
  );
  TextEditingController _noiDungController = TextEditingController(
    text: "Nội Dung",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Công việc"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
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
            Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: _tieuDeController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _noiDungController,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 16),
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
