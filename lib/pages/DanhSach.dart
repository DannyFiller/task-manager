// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/ChiTiet.dart';
import 'package:task_manager/pages/themcongviec.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/services/databaseService.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/trangchu.dart';

class DanhSach extends StatefulWidget {
  const DanhSach({super.key});

  @override
  State<DanhSach> createState() => _DanhSachState();
}

class _DanhSachState extends State<DanhSach> {
  List<Congviec> lstCongViec = [];
  var logger = Logger();

  late Future<List<Congviec>> congViec;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      congViec = _loadProData();
    });
  }

  Future<List<Congviec>> _loadProData() async {
    lstCongViec = await DatabaseService.instance.readAllCongviec();
    return lstCongViec;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        // automaticallyImplyLeading: false,
        title: const Text("Danh sách công việc"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Congviec>>(
        future: congViec,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có công việc nào.'));
          } else {
            // Cập nhật lstCongViec khi dữ liệu được trả về
            lstCongViec = snapshot.data!;
            return ListView.builder(
              itemCount: lstCongViec.length,
              itemBuilder: (context, index) {
                return item(context, index, lstCongViec);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThemCongViec(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget item(BuildContext context, int index, List<Congviec> lst) {
  return Consumer<ListVSM>(
    builder: (BuildContext context, ListVSM value, Widget? child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChiTiet(
                    index: index,
                    congviec: lst[index],
                  ),
                ));
          },
          title: Text(
            lst[index].tieuDeCongViec.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            lst[index].noiDung.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const Icon(Icons.work),
          trailing: Wrap(
            spacing: 6,
            children: <Widget>[
              // Checkbox(
              //   value: lst[index].trangThai,
              //   onChanged: (bool? newValue) {
              //     if (newValue != null) {
              //       lst[index].trangThai = newValue;
              //       value.notifyListeners();
              //     }
              //   },
              // ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    value.xoaCongViec(lst[index].tieuDeCongViec!);
                    ShowDialog(context);
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void ShowDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Đã Xóa"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrangChu(),
                      ));
                },
                child: const Text("Trở lại"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
