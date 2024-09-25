import 'package:flutter/material.dart';

class Caidat extends StatefulWidget {
  const Caidat({super.key});

  @override
  State<Caidat> createState() => _CaidatState();
}

class _CaidatState extends State<Caidat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Cài Đặt"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.mode_night_outlined),
                title: Text(
                  "Cài đặt sáng tối",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.mode_night_outlined),
                title: Text(
                  "Cài đặt kích cỡ chữ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.mode_night_outlined),
                title: Text(
                  "Cài đặt màu chữ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
