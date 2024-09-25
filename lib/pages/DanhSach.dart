// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_manager/pages/ChiTiet.dart';
import 'package:task_manager/pages/themcongviec.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';

class DanhSach extends StatefulWidget {
  const DanhSach({super.key});

  @override
  State<DanhSach> createState() => _DanhSachState();
}

class _DanhSachState extends State<DanhSach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        // automaticallyImplyLeading: false,
        title: const Text("Danh sách công việc"),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Consumer<ListVSM>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.danhsach.length,
                  itemBuilder: (context, index) {
                    return item(context, index);
                  },
                );
              },
            ),
            Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 80,
                  height: 50,
                  child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThemCongViec(),
                            ));
                      },
                      child: const Icon(Icons.add)),
                ))
          ],
        ),
      ),
    );
  }
}

Widget item(BuildContext context, int index) {
  return Consumer<ListVSM>(
    builder: (BuildContext context, ListVSM value, Widget? child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ChiTiet();
              },
            ));
          },
          title: Text(value.danhsach[index].tieuDeCongViec.toString()),
          subtitle: Text(value.danhsach[index].noiDung.toString()),
          leading: const Icon(Icons.work),
          trailing: Wrap(
            spacing: 12,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  ShowDialog(context);
                },
                child: Icon(Icons.edit),
              ),
              GestureDetector(
                onTap: () {
                  value.xoaCongViec(index);
                },
                child: Icon(Icons.delete),
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
          height: 300,
          width: MediaQuery.of(context).size.height * 0.5,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("data")],
          ),
        ),
      );
    },
  );
}

PageChiTiet(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return const ChiTiet();
    },
  ));
}
