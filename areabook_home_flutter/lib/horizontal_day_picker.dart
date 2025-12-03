import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDayPicker extends StatefulWidget {
  final DateTime startDate; // usually "today"
  final int totalDays; // e.g. 14 for 2 weeks
  final Function(DateTime) onDateSelected;
  final DateTime? initialSelectedDate;

  const HorizontalDayPicker({
    super.key,
    required this.startDate,
    this.totalDays = 14,
    required this.onDateSelected,
    this.initialSelectedDate,
  });

  @override
  State<HorizontalDayPicker> createState() => _HorizontalDayPickerState();
}

class _HorizontalDayPickerState extends State<HorizontalDayPicker> {
  late DateTime selectedDate;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialSelectedDate ?? widget.startDate;

    // Scroll current day into view after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _scrollToSelected() {
    final currentIndex = selectedDate.difference(widget.startDate).inDays + widget.totalDays ~/ 2;
    final itemWidth = 70.0; // matches your container width
    final scrollOffset = currentIndex * itemWidth;

    _scrollController.jumpTo(scrollOffset - 20);    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.totalDays,
        itemBuilder: (context, index) {
          // Center around the initial selected date
          final date = widget.startDate.add(Duration(days: index - widget.totalDays ~/ 2));

          final bool isToday = isSameDay(date, DateTime.now());
          final bool isSelected = isSameDay(date, selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() => selectedDate = date);
              widget.onDateSelected(date);
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isToday
                    ? const Color.fromARGB(255, 226, 244, 255)
                    : (index % 2 == 0
                        ? const Color.fromARGB(255, 247, 248, 248)
                        : Colors.grey.shade200),
                border: Border.all(
                  color: isSelected ? const Color.fromARGB(255, 1, 182, 209) : Colors.transparent,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
