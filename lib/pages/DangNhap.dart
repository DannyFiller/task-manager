import 'package:flutter/material.dart';
import 'package:task_manager/services/authService.dart';
import 'package:task_manager/utilities/const.dart';

class DangNhap extends StatefulWidget {
  const DangNhap({super.key});

  @override
  State<DangNhap> createState() => _DangNhapState();
}

class _DangNhapState extends State<DangNhap> {
  DateTime? _selectedDate;

  // Hàm để hiển thị DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Ngày mặc định là hôm nay
      firstDate: DateTime(2000), // Ngày bắt đầu có thể chọn
      lastDate: DateTime(2101), // Ngày kết thúc có thể chọn
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Authservice authservice = Authservice();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController matKhauController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("${urlImage}logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Text(
                      "Đăng Nhập",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.timelapse_outlined),
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
                      obscureText: true,
                      controller: matKhauController,
                      decoration: const InputDecoration(
                        hintText: "Mật khấu",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.timelapse_outlined),
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
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: FilledButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        authservice.SignIn(
                            email: emailController.text,
                            password: matKhauController.text,
                            context: context);
                      },
                      child: const Text(
                        "Đăng Nhập",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
