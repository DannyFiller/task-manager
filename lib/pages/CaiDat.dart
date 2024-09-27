import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/DangNhap.dart';
import 'package:task_manager/providers/UIProvider.dart';

class Caidat extends StatefulWidget {
  const Caidat({super.key});

  @override
  State<Caidat> createState() => _CaidatState();
}

class _CaidatState extends State<Caidat> {
  List<Congviec> lstCongViec = [];

  @override
  void initState() {
    super.initState();
  }

  void logOut() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DangNhap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Cài Đặt"),
        centerTitle: true,
      ),
      body:
          Consumer<Uiprovider>(builder: (context, Uiprovider notifier, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.mode_night_outlined),
                  title: const Text(
                    "Cài đặt sáng tối",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  trailing: Switch(
                    value: notifier.isDark,
                    onChanged: (value) => notifier.changeTheme(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: const ListTile(
                  leading: Icon(Icons.font_download_outlined),
                  title: Text(
                    "Cài đặt kích cỡ chữ",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: const ListTile(
                  leading: Icon(Icons.colorize_outlined),
                  title: Text(
                    "Cài đặt màu chữ",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DangNhap(),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: const ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Đăng xuất",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
