// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/ChiTiet.dart';
import 'package:task_manager/pages/danhSachTatCa.dart';
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
  List<Congviec> lstChuaHoanThanh = [];
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
    lstChuaHoanThanh =
        await DatabaseService.instance.readAllCongviecChuaHoanThanh();

    setState(() {
      int a = lstCongViec.where((congViec) => congViec.trangThai!).length;
      int b = lstCongViec.where((congViec) => !congViec.trangThai!).length;
      setValue(a, b);

      print(lstCongViec.length);
    });
    return lstCongViec;
  }

  Map<String, double> dataMap = {
    "Công việc chưa hoàn thành": 1,
    "Công việc đã hoàn thành": 1,
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
          'Thống Kê Công Việc',
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
            const Divider(),
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
            ),
            const Divider(),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DanhSachTatCa(),
                    ));
              },
              child: Container(
                height: 40,
                // width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Danh sách tất cả các công việc",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
            const Divider(),
            const Text(
              'Danh sách công việc chưa làm',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ReorderableListView(
                children: List.generate(
                  lstChuaHoanThanh.length,
                  (index) => Container(
                    key: Key("$index"),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChiTiet(
                                index: lstChuaHoanThanh.length,
                                congviec: lstChuaHoanThanh[index],
                                // congviec: lst[index],
                              ),
                            ));
                      },
                      title: Text(
                        lstChuaHoanThanh[index].tieuDeCongViec.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        lstChuaHoanThanh[index].noiDung.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.work),
                      trailing: Wrap(
                        spacing: 6,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                xoaCongViec(lstChuaHoanThanh[index].id!);
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
                  ),
                ),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = lstChuaHoanThanh.removeAt(oldIndex);
                    lstChuaHoanThanh.insert(newIndex, item);
                  });
                },
              ),
            ),
            const Divider(),
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
