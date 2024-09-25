import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/pages/chitiet.dart';

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
          Text(today.toString()),
          const Divider(),
          const Text(
            "Danh sách công việc",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) => item(context, today),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget item(BuildContext context, DateTime date) {
  return Container(
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
      title: const Text("Công việc"),
      subtitle: Text("Mô tả công việc " + date.toString()),
      leading: const Icon(Icons.work),
    ),
  );
}
