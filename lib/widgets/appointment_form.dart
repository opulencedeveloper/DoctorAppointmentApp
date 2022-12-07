import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

class AppointmentForm extends StatefulWidget {
  final DateTime sDate = DateTime.now();
  final String? sTime = "";

  AppointmentForm({Key? key}) : super(key: key);
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  var dateController = TextEditingController();
  var _timeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  //TimeOfDay time = TimeOfDay.now();
  //TimeOfDay? newTime;
  //DateTime? tempDate;
  String? time;
// void _presentTimePicker() async {
//     newTime = showTimePicker(
//       context: context,
//       initialTime: time,
//     );
//     // print('...');
//   }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = intl.DateFormat.yMMMMEEEEd().format(_selectedDate).toString();
      });
    });
    // print('...');
  }

  void _presentTimePicker() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime == null) {
      return;
    }
    setState(() {
      time = newTime.format(context);
      _timeController.text = time.toString();
      //time = newTime.replacing(hour: newTime.hourOfPeriod);
      // print(time.period);
      //tim = time.period == DayPeriod.am ? 'AM' : 'PM';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // SizedBox(
                //   height: 13,
                //   width: 200,
                //   child: TextField(
                //     readOnly: true,
                //     controller: dateController,
                //     textAlign: TextAlign.right,
                //     style: const TextStyle(
                //       fontSize: 13,
                //     ),
                //     decoration: InputDecoration(
                //       // labelText: 'Search',
                //       floatingLabelBehavior: FloatingLabelBehavior.never,
                //       contentPadding: const EdgeInsets.symmetric(
                //         vertical: 0,
                //       ),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //     ),
                //     onTap: null,
                //     // onChanged: (val) => amountInput = val,
                //   ),
                // ),
                Text(
                  '${intl.DateFormat.yMMMMEEEEd().format(_selectedDate)}',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: OutlinedButton.icon(
                onPressed: _presentDatePicker,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 20.0),
                label: const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    "Select Appointment Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.only(right: 0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // SizedBox(
                //   height: 13,
                //   width: 200,
                //   child: TextField(
                //     readOnly: true,
                //     controller: _timeController,
                //     textAlign: TextAlign.right,
                //     style: const TextStyle(
                //       fontSize: 13,
                //     ),
                //     decoration: InputDecoration(
                //       // labelText: 'Search',
                //       floatingLabelBehavior: FloatingLabelBehavior.never,
                //       contentPadding: const EdgeInsets.symmetric(
                //         vertical: 0,
                //       ),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //     ),
                //     onTap: null,
                //     // onChanged: (val) => amountInput = val,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: OutlinedButton.icon(
                onPressed: _presentTimePicker,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 20.0),
                label: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    time != null ? '$time' : 'Select Appoointment Time',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.only(right: 0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
