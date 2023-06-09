import 'package:employee_list/constants/app_colors.dart';
import 'package:employee_list/constants/theme_text.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Employee Details", style: getTextHeading()),
          backgroundColor: AppColors.colorBlue),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            style: getTextHeading(color: AppColors.colorBlack, fontSize: 12),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.people, color: AppColors.colorBlue),
              hintText: "Employee Name",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: roleController,
            style: getTextHeading(color: AppColors.colorBlack, fontSize: 12),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.work_outline_outlined,
                  color: AppColors.colorBlue),
              hintText: "Select Role",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              suffixIcon:
                  const Icon(Icons.arrow_drop_down, color: AppColors.colorBlue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDateTile(),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.colorBlue,
              ),
              customDateTile()
            ],
          ),
          const Spacer(),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildButton(
                  buttonText: "Cancel",
                  textColor: AppColors.colorBlue,
                  backgroundColor: AppColors.colorSkyBlue.withOpacity(.2)),
              buildButton(
                buttonText: "Save",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      {required String buttonText,
      Color textColor = AppColors.colorWhite,
      Color backgroundColor = AppColors.colorBlue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 10, left: 20),
      child: Container(
          height: 30,
          width: 80,
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
    );
  }

  Widget customDateTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      width: MediaQuery.of(context).size.width / 2 - 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorDarkGrey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            color: AppColors.colorBlue,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Today")
        ],
      ),
    );
  }
}
