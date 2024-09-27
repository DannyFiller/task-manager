// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/ChiTiet.dart';
import 'package:task_manager/pages/themcongviec.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/services/databaseService.dart';
import 'package:logger/logger.dart';
import 'package:pie_chart/pie_chart.dart';

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
    // lstCongViec = await Provider.of<ListVSM>(context, listen: false).LoadData();
    setState(() {
      int b = lstCongViec.where((congViec) => congViec.trangThai!).length;
      int a = lstCongViec.where((congViec) => !congViec.trangThai!).length;
      setValue(a, b);

      // lstCongViec = await Provider.of<ListVSM>(context, listen: false).LoadData();
      print(lstCongViec.length);
    });
    return lstCongViec;
  }

  Map<String, double> dataMap = {
    "Công việc đã hoàn thành": 1,
    "Công việc chưa hoàn thành": 1,
  };
  void setValue(int a, int b) {
    dataMap["Công việc đã hoàn thành"] = a.toDouble();
    dataMap["Công việc chưa hoàn thành"] = b.toDouble();
  }

  void xoaCongViec(int id) {
    Provider.of<ListVSM>(context, listen: false).xoaCongViec(id);
    setState(() {
      congViec = _loadProData(); // Gọi lại dữ liệu mới
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Tình Trạng Công Việc',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Text(
              'Tổng Số Công Việc : ${lstCongViec.length}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 32,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
            const Divider(),
            const Text(
              'Danh sách công việc',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Congviec>>(
                future: congViec,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có công việc nào.'));
                  } else {
                    lstCongViec = snapshot.data!;
                    return ListView.builder(
                      itemCount: lstCongViec.length,
                      itemBuilder: (context, index) {
                        return item(context, index, lstCongViec);
                      },

                      // itemCount: lstCongViec.length,
                      // itemBuilder: (context, index) {
                      //   return item(context, index, lstCongViec);
                      // },
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
                      index: lst.length,
                      congviec: lst[index],
                      // congviec: lst[index],
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      xoaCongViec(lst[index].id!);
                      // ShowDialog(context);
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
                const Text(
                  "Đã Xóa",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Tiếp tục",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
