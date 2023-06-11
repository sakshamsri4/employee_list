import 'package:employee_list/constants/app_colors.dart';
import 'package:employee_list/constants/app_strings.dart';
import 'package:employee_list/constants/custom_widget.dart';
import 'package:employee_list/constants/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_calendar.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  String? startDate;

  String endDate = AppStrings.textNoDate;
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(AppStrings.textAddEmployeeDetails, style: getTextHeading()),
          backgroundColor: AppColors.colorBlue),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          buildEmployeeName(),
          const SizedBox(
            height: 20,
          ),
          buildRole(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDateTile(
                  day: startDate ?? AppStrings.textToday,
                  onTap: () {
                    showCustomCalendar(context);
                  }),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.colorBlue,
              ),
              customDateTile(
                  day: endDate,
                  start: false,
                  onTap: () {
                    showCustomCalendar(context, start: false);
                  })
            ],
          ),
          const Spacer(),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomWidget().buildButton(
                  buttonText: AppStrings.textCancel,
                  textColor: AppColors.colorBlue,
                  backgroundColor: AppColors.colorSkyBlue.withOpacity(.2),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              CustomWidget()
                  .buildButton(buttonText: AppStrings.textSave, onTap: () {}),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future buildBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                List<String> roles = [
                  AppStrings.textProductDesigner,
                  AppStrings.textFlutterDeveloper,
                  AppStrings.textQaTester,
                  AppStrings.textProductOwner,
                ];
                return ListTile(
                  title: Center(child: Text(roles[index])),
                  onTap: () {
                    roleController.text = roles[index];
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> showCustomCalendar(BuildContext context,
      {bool start = true}) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * .9,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomCalendar(
                  start: start,
                )),
          ),
        );
      },
    );
    setState(() {
      if (start) {
        startDate = result.toString().isNotEmpty
            ? result.toString() !=
                    DateFormat('d MMM yyyy').format(DateTime.now())
                ? result.toString()
                : AppStrings.textToday
            : AppStrings.textToday;
        if (result == null) {
          startDate = AppStrings.textToday;
        }
      } else {
        endDate = result.toString().isNotEmpty
            ? result.toString() !=
                    DateFormat('d MMM yyyy').format(DateTime.now())
                ? result.toString()
                : AppStrings.textToday
            : AppStrings.textNoDate;
        if (result == null) {
          endDate = AppStrings.textNoDate;
        }
      }
    });
  }

  Widget customDateTile(
      {required String day, required onTap, bool start = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        width: MediaQuery.of(context).size.width / 2 - 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.colorDarkGrey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.colorBlue,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              day,
              style: getTextHeading(
                  color: start ? AppColors.colorBlack : AppColors.colorDarkGrey,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmployeeName() {
    return TextFormField(
      controller: nameController,
      style: getTextHeading(color: AppColors.colorBlack, fontSize: 12),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.people, color: AppColors.colorBlue),
        hintText: AppStrings.textEmployeeName,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
    );
  }

  Widget buildRole() {
    return TextFormField(
      controller: roleController,
      readOnly: true,
      style: getTextHeading(color: AppColors.colorBlack, fontSize: 12),
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.work_outline_outlined, color: AppColors.colorBlue),
        hintText: AppStrings.textSelectRole,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        suffixIcon:
            const Icon(Icons.arrow_drop_down, color: AppColors.colorBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      onTap: () {
        buildBottomSheet();
      },
    );
  }
}
