import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class ScrollableCalendarScreen extends StatefulWidget {
  @override
  _ScrollableCalendarScreenState createState() =>
      _ScrollableCalendarScreenState();
}

class _ScrollableCalendarScreenState extends State<ScrollableCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  ScrollController _scrollController = ScrollController();

  void _scrollToMonth(int month) {
    final position = (month - 1) *
        250.h; // Har bir oyni o'rtacha balandligi 400.0 deb hisoblaymiz
    _scrollController.animateTo(
      position,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    _scrollController.animateTo(
      200,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Scrollable Calendar'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(20, (index) {
            DateTime firstDayOfMonth = DateTime(_focusedDay.year, index + 1, 1);
            DateTime lastDayOfMonth =
                DateTime(_focusedDay.year + 3, index + 2, 0);

            DateTime focusDay = (firstDayOfMonth.month == _focusedDay.month)
                ? _focusedDay
                : firstDayOfMonth;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                currentDay: DateTime.now(),
                firstDay: firstDayOfMonth,
                lastDay: lastDayOfMonth,
                focusedDay: focusDay,
                sixWeekMonthsEnforced: false,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _scrollToMonth(selectedDay.month);
                  });
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  todayDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Icon(Icons.chevron_left),
                  rightChevronIcon: Icon(Icons.chevron_right),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (day.day % 2 == 0) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    } else if (day.day % 3 == 0) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
