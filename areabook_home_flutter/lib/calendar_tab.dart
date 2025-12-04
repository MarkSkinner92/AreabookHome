import 'package:flutter/material.dart';
import 'calendar.dart';
import 'horizontal_day_picker.dart';
import 'package:intl/intl.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 1, 65),
        elevation: 0,
        title: Text(
          DateFormat('MMM d').format(selectedDate),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          HorizontalDayPicker(
            startDate: DateTime.now(),
            totalDays: 14,
            initialSelectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),

          Expanded(
            child: CalendarPage(
              selectedDate: selectedDate,
            ),
          ),
        ],
      ),
    );
  }

}
