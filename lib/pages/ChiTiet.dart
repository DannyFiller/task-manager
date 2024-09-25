import 'package:flutter/material.dart';

class ChiTiet extends StatefulWidget {
  const ChiTiet({super.key});

  @override
  State<ChiTiet> createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Công việc"),
      ),
      body: const Center(
        child: Text("Chi Tiết"),
      ),
    );
  }
}
