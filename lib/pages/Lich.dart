import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/chitiet.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/services/databaseService.dart';

class Lich extends StatefulWidget {
  const Lich({super.key});

  @override
  State<Lich> createState() => _LichState();
}

class _LichState extends State<Lich> {
  List<Congviec> lstCongViec = [];
  late Future<List<Congviec>> congViec;

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  Future<List<Congviec>> _loadProData() async {
    lstCongViec = await DatabaseService.instance.readAllCongviec();
    return lstCongViec;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    congViec = _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Lịch Công Việc",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            TableCalendar(
              locale: "vi",
              focusedDay: today,
              firstDay: DateTime.utc(today.year - 10, today.month),
              lastDay: DateTime.utc(today.year + 10, today.month),
              pageAnimationEnabled: false,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onDaySelected: _onDaySelected,
            ),
            const Divider(),
            const Text(
              "Danh sách công việc",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            FutureBuilder(
              future: congViec,
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: lstCongViec.length,
                    itemBuilder: (context, index) =>
                        item(context, index, today, lstCongViec),
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}

Widget item(
    BuildContext context, int index, DateTime today, List<Congviec> lst) {
  return Consumer<ListVSM>(
    builder: (context, value, child) {
      bool kiemTraCungNgay = isSameDay(today, lst[index].ngayLamViec!);
      return kiemTraCungNgay
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ChiTiet(
                        index: index,
                        congviec: lst[index],
                      );
                    },
                  ));
                },
                title: Text(
                  lst[index].tieuDeCongViec.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  lst[index].noiDung.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: const Icon(Icons.work),
              ),
            )
          : const SizedBox();
    },
  );
}
