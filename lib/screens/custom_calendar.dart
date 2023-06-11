import 'package:employee_list/constants/app_colors.dart';
import 'package:employee_list/constants/app_strings.dart';
import 'package:employee_list/constants/custom_widget.dart';
import 'package:employee_list/constants/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  final bool start;

  const CustomCalendar({super.key, required this.start});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  String selectedDateString = DateFormat('d MMM yyyy').format(DateTime.now());
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();
  DateTime? today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: widget.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(
                    buttonText: AppStrings.textToday,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        selectedDay = today;
                        selectedDateString = DateFormat('d MMM yyyy')
                            .format(selectedDay ?? DateTime.now());

                        focusedDay = selectedDay ?? DateTime.now();
                      });
                    }),
                buildButton(
                    buttonText: AppStrings.textNextMonday,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        selectedDay = selectedDay!
                            .add(Duration(days: 8 - selectedDay!.weekday));
                        selectedDateString =
                            DateFormat('d MMM yyyy').format(selectedDay!);

                        focusedDay = selectedDay!;
                      });
                    }),
              ],
            ),
          ),
          Visibility(
            visible: widget.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(
                    buttonText: AppStrings.textNextMonday,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        int nextTuesday = selectedDay!.weekday >= 2
                            ? (7 - selectedDay!.weekday + 2)
                            : (2 - selectedDay!.weekday);

                        selectedDay =
                            selectedDay!.add(Duration(days: nextTuesday));
                        selectedDateString =
                            DateFormat('d MMM yyyy').format(selectedDay!);

                        focusedDay = selectedDay!;
                      });
                    }),
                buildButton(
                    buttonText: AppStrings.textAfterOneWeek,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        selectedDay = selectedDay!.add(const Duration(days: 7));
                        selectedDateString =
                            DateFormat('d MMM yyyy').format(selectedDay!);

                        focusedDay = selectedDay!;
                      });
                    }),
              ],
            ),
          ),
          Visibility(
            visible: !widget.start,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(
                    buttonText: AppStrings.textNoDate,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        selectedDay = null;
                        selectedDateString = "No Date";

                        focusedDay = DateTime.now();
                      });
                    }),
                buildButton(
                    buttonText: AppStrings.textToday,
                    backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                    textColor: AppColors.colorBlue,
                    onChanged: () {
                      setState(() {
                        selectedDay = today;
                        selectedDateString =
                            DateFormat('d MMM yyyy').format(selectedDay!);

                        focusedDay = selectedDay!;
                      });
                    }),
              ],
            ),
          ),
          buildTableCalendar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.colorBlue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(selectedDateString),
                  ],
                ),
                Row(
                  children: [
                    CustomWidget().buildButton(
                        buttonText: AppStrings.textCancel,
                        textColor: AppColors.colorBlue,
                        width: 60,
                        backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                        onTap: () {
                          selectedDateString = "";
                          Navigator.pop(context, selectedDateString);
                        }),
                    CustomWidget().buildButton(
                        buttonText: AppStrings.textSave,
                        width: 60,
                        onTap: () {
                          Navigator.pop(context, selectedDateString);
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      {required String buttonText,
      Color textColor = AppColors.colorWhite,
      Color backgroundColor = AppColors.colorBlue,
      required Function() onChanged}) {
    return GestureDetector(
      onTap: onChanged,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, top: 0, left: 10),
        child: Container(
            width:
                (MediaQuery.of(context).size.width / 4.0).truncateToDouble() +
                    10,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: AppColors.colorDarkGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
                child: Text(
              buttonText,
              style: getTextHeading(color: textColor, fontSize: 14),
            ))),
      ),
    );
  }

  Widget buildTableCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDay!,
      selectedDayPredicate: (day) =>
          selectedDay != null && isSameDay(selectedDay!, day),
      onDaySelected: (selected, focused) {
        setState(() {
          focusedDay = focused;
          selectedDay = selected;
          selectedDateString = DateFormat('d MMM yyyy').format(selectedDay!);
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        // Set to false to remove the "2 Weeks" button
        titleCentered: true,
        titleTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.blue),
        leftChevronIcon: const Icon(
          Icons.arrow_left_sharp,
          size: 30,
          color: AppColors.colorDarkGrey,
        ),
        rightChevronIcon: const Icon(
          Icons.arrow_right_sharp,
          size: 30,
          color: AppColors.colorDarkGrey,
        ),
        leftChevronMargin: const EdgeInsets.only(left: 10),
        rightChevronMargin: const EdgeInsets.only(right: 10),
      ),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) => Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            // This is your light circle around today's date
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: const TextStyle(
                color: Colors.blue), // You can style the text as you want
          ),
        ),
        selectedBuilder: (context, date, _) => Container(
          margin: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
            // This is the color for the selected day
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: const TextStyle(
                color: Colors.white), // You can style the text as you want
          ),
        ),
      ),
      currentDay: today,
      calendarFormat: CalendarFormat.month,
    );
  }
}
