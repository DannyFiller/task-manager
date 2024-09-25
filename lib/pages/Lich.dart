import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/models/congViec.dart';
import 'package:task_manager/pages/chitiet.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/ListVSM.dart';

class Lich extends StatefulWidget {
  const Lich({super.key});

  @override
  State<Lich> createState() => _LichState();
}

class _LichState extends State<Lich> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const Text("Lịch Công Việc"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            TableCalendar(
              locale: "vi",
              focusedDay: today,
              firstDay: DateTime.utc(today.year - 10, today.month),
              lastDay: DateTime.utc(today.year + 10, today.month),
              pageAnimationEnabled: false,
              // currentDay: DateTime.utc(today.year, today.month, today.day),
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
            Consumer<ListVSM>(
              builder: (BuildContext context, ListVSM value, Widget? child) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.danhsach.length,
                    itemBuilder: (context, index) =>
                        item(context, index, today),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

Widget item(BuildContext context, int index, DateTime today) {
  return Consumer<ListVSM>(
    builder: (context, value, child) {
      bool kiemTraCungNgay =
          isSameDay(today, value.danhsach[index].ngayLamViec!);
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
                      return const ChiTiet();
                    },
                  ));
                },
                title: Text(value.danhsach[index].ngayLamViec.toString()),
                subtitle: Text(value.danhsach[index].noiDung.toString()),
                leading: const Icon(Icons.work),
              ),
            )
          : SizedBox();
    },
  );
}

// void get(BuildContext context, DateTime today) {
//   List<Congviec> lst = Provider.of<ListVSM>(context, listen: false)
//       .danhsach
//       .where((congviec) => congviec.ngayLamViec == today)
//       .cast<Congviec>()
//       .toList();
//   ;
// }

// Widget check(DateTime today) {
//   return Consumer<ListVSM>(
//     builder: (context, value, child) {
//       return today.isAtSameMomentAs(value.danhsach[1].ngayLamViec!)
//           ? Text("!= | ${today} | ${value.danhsach[1].ngayLamViec}")
//           : Text("==");
//     },
//   );
// }

// Consumer<ListVSM>(
//     builder: (context, value, child) {
//       return today == value.danhsach[index].ngayLamViec
//           ? Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return const ChiTiet();
//                     },
//                   ));
//                 },
//                 title: Text(value.danhsach[index].ngayLamViec.toString()),
//                 subtitle: Text(value.danhsach[index].noiDung.toString()),
//                 leading: const Icon(Icons.work),
//               ),
//             )
//           : SizedBox();
//     },
//   );

//  Consumer<ListVSM>(
//     builder: (context, value, child) {
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(10)),
//         child: ListTile(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
//                 return const ChiTiet();
//               },
//             ));
//           },
//           title: Text(value.danhsach[index].ngayLamViec.toString()),
//           subtitle: Text(value.danhsach[index].noiDung.toString()),
//           leading: const Icon(Icons.work),
//         ),
//       );
//     },
//   );

// return Consumer<ListVSM>(
//     builder: (context, value, child) {
//       bool kiemTraCungNgay =
//           isSameDay(today, value.danhsach[index].ngayLamViec!);
//       return kiemTraCungNgay
//           ? Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return const ChiTiet();
//                     },
//                   ));
//                 },
//                 title: Text(value.danhsach[index].ngayLamViec.toString()),
//                 subtitle: Text(value.danhsach[index].noiDung.toString()),
//                 leading: const Icon(Icons.work),
//               ),
//             )
//           : SizedBox();
//     },
//   );