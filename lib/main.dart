import 'package:flutter/material.dart';
import 'package:task_manager/pages/DangNhap.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  runApp(const MainApp());
  await initializeDateFormatting('vi', null);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DangNhap(),
      ),
    );
  }
}
