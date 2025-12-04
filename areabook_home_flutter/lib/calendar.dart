import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String title;
  TimeOfDay start;
  TimeOfDay end;
  final Color color;
  double? dragStartMinutes;
  double? dragEventDuration;
  Event({
    required this.title,
    required this.start,
    required this.end,
    required this.color,
  });
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

TimeOfDay minutesToTimeOfDay(int minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  return TimeOfDay(hour: hours, minute: remainingMinutes);
}

class CalendarPage extends StatefulWidget {
  final DateTime selectedDate;

  const CalendarPage({super.key, required this.selectedDate});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late PageController _pageController;
  DateTime baseDate = DateTime(2025, 8, 11);
  int initialPage = 10000;

  final List<Event> events = [
    Event(
      title: 'STUDY OR PLAN',
      start: TimeOfDay(hour: 8, minute: 0),
      end: TimeOfDay(hour: 10, minute: 0),
      color: const Color(0xFFF3E4FF),
    ),
    Event(
      title: 'TRAVEL',
      start: TimeOfDay(hour: 10, minute: 30),
      end: TimeOfDay(hour: 11, minute: 0),
      color: const Color(0xffFFE8EB),
    ),
    Event(
      title: 'CONTACT',
      start: TimeOfDay(hour: 11, minute: 0),
      end: TimeOfDay(hour: 13, minute: 0),
      color: const Color(0xFFEFFFE6),
    ),
    Event(
      title: 'SERVICE',
      start: TimeOfDay(hour: 13, minute: 30),
      end: TimeOfDay(hour: 14, minute: 30),
      color: const Color(0xFFE2F4FF),
    ),
    Event(
      title: 'FINDING',
      start: TimeOfDay(hour: 14, minute: 0),
      end: TimeOfDay(hour: 16, minute: 0),
      color: const Color(0xFFFFE7FD),
    ),
    Event(
      title: 'TEACHING',
      start: TimeOfDay(hour: 16, minute: 0),
      end: TimeOfDay(hour: 17, minute: 0),
      color: const Color(0xFFFFF6D5),
    ),
    Event(
      title: 'DINNER',
      start: TimeOfDay(hour: 17, minute: 0),
      end: TimeOfDay(hour: 18, minute: 0),
      color: const Color(0xFFFFF7EA),
    ),
  ];

  DateTime currentDate = DateTime(2025, 8, 11);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (pageIndex) {
              setState(() {
                currentDate = baseDate.add(
                  Duration(days: pageIndex - initialPage),
                );
              });
            },
            itemBuilder: (context, index) {
              final date = baseDate.add(Duration(days: index - initialPage));
              return buildDay(date);
            },
          ),
        ),
      ],
    );
  }

  Widget buildDay(DateTime selectedDate) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 24 * 60,
        child: Stack(
          children: [
            Column(
              children: List.generate(24, (index) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                        child: Text(
                          '${index % 12 == 0 ? 12 : index % 12} ${index < 12 ? 'AM' : 'PM'}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            ...events.map((e) {
              double startY = e.start.hour * 60 + e.start.minute.toDouble();
              double height = (e.end.hour * 60 + e.end.minute) - startY;

              return Positioned(
                top: startY,
                left: 60,
                right: 16,
                height: height,
                child: GestureDetector(
                  // same drag logic...
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: e.color,
                      border: Border(
                        left: BorderSide(color: e.color.darken(), width: 4),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${e.title}  ${e.start.format(context)} - ${e.end.format(context)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
