import 'package:flutter/material.dart';

class ThemCongViec extends StatefulWidget {
  const ThemCongViec({super.key});

  @override
  State<ThemCongViec> createState() => _ThemCongViecState();
}

class _ThemCongViecState extends State<ThemCongViec> {
  final List<String> items = [
    'Online',
    'Offline',
  ];

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 7, minute: 0);

  final TextEditingController _thoiGianController = TextEditingController();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm Công Việc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            children: [
              Text(_timeOfDay.toString()),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Tiêu đề công việc"),
                    prefixIcon: Icon(Icons.calendar_today),
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
                  decoration: const InputDecoration(
                    label: Text("Nội dung công việc"),
                    prefixIcon: Icon(Icons.calendar_today),
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
                  decoration: const InputDecoration(
                    label: Text("Ngày làm việc"),
                    prefixIcon: Icon(Icons.calendar_today),
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
                  controller: _thoiGianController,
                  onTap: () {
                    _showTimePicker();
                  },
                  decoration: const InputDecoration(
                    label: Text("Thời gian làm việc"),
                    prefixIcon: Icon(Icons.timelapse_outlined),
                    enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  readOnly: true,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Địa Điểm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Ghi chú"),
                    prefixIcon: Icon(Icons.note_add_outlined),
                    enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  height: 60,
                  // width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Luư Công Việc",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
