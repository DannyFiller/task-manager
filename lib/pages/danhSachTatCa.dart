import 'package:flutter/material.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/chiTiet.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/services/databaseService.dart';
import 'package:provider/provider.dart';

class DanhSachTatCa extends StatefulWidget {
  const DanhSachTatCa({super.key});

  @override
  State<DanhSachTatCa> createState() => _DanhSachTatCaState();
}

class _DanhSachTatCaState extends State<DanhSachTatCa> {
  List<Congviec> lstCongViec = [];

  Future<List<Congviec>> _loadProData() async {
    lstCongViec = await DatabaseService.instance.readAllCongviec();
    return lstCongViec;
  }

  late Future<List<Congviec>> congViec;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      congViec = _loadProData();
    });
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
        title: const Text("Danh Sách Công Việc"),
      ),
      body: Column(
        children: [
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
                  );
                }
              },
            ),
          ),
        ],
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
}
