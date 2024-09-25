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
      body: Container(),
    );
  }
}
