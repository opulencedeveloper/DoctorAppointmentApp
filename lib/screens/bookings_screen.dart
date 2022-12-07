import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../screens/payment_option_screen.dart';

class BookingsScreen extends StatefulWidget {
  static const routeName = "/bookings-route-name";
  const BookingsScreen({Key? key}) : super(key: key);
  @override
  BookingsScreenState createState() => BookingsScreenState();
}

class BookingsScreenState extends State<BookingsScreen> {
  var _loadedInitData = false;
  var _doctorId = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      _doctorId = ModalRoute.of(context)!.settings.arguments.toString();
      print('route');
    }
    _loadedInitData = true;
  }
  //   List<DynamicWidget> listDynamic = [];
  // List<String> data = [];

  DateTime? _selectedDate;
  //TimeOfDay time = TimeOfDay.now();
  //TimeOfDay? newTime;
  //DateTime? tempDate;
  String? time;
  var appointment = 0;
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2222),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
      //time = newTime.replacing(hour: newTime.hourOfPeriod);
      // print(time.period);
      //tim = time.period == DayPeriod.am ? 'AM' : 'PM';
    });
  }

  void _onEmpty() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Please select an appointment date with time",
        ),
        duration: Duration(seconds: 2),
        // action: SnackBarAction(
        //     label: "UNDO",
        //     onPressed: () {
        //       cart.UndoRemoveSingleItem(loadedFood.id);
        //     }),
      ),
    );
    // return;
  }

  void _showMessage() {
    if (_selectedDate == null || time == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text(
            "Please select an appointment date with time",
          ),
          duration: const Duration(seconds: 2),
          // action: SnackBarAction(
          //     label: "UNDO",
          //     onPressed: () {
          //       cart.UndoRemoveSingleItem(loadedFood.id);
          //     }),
        ),
      );
      return;
    }
    if (appointment >= 3) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Sorry"),
          content: const Text("You cannot book more than 3 appointments"),
          actions: [
            ElevatedButton(
              child: const Text("Okay"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Booking added",
        ),
        duration: Duration(seconds: 2),
        // action: SnackBarAction(
        //     label: "UNDO",
        //     onPressed: () {
        //       cart.UndoRemoveSingleItem(loadedFood.id);
        //     }),
      ),
    );
    setState(() {
      appointment++;
      _selectedDate = null;
      time = null;
      print('reached');
    });
  }

  //DateTime chosenDate = DateTime.now();
  //String? time;
  // List<AppointmentForm> listDynamic = [
  //   AppointmentForm(),
  // ];

  // addDynamic() {
  //   if (listDynamic.length >= 3) {
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text("Sorry"),
  //         content: const Text("You cannot book more than 3 appointments"),
  //         actions: [
  //           ElevatedButton(
  //             child: const Text("Okay"),
  //             onPressed: () {
  //               Navigator.of(ctx).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //     return;
  //   }
  //   listDynamic.add(AppointmentForm());
  //   setState(() {});
  // }

  // submitData() {

  //   data = [];

  //   listDynamic.forEach((widget) => data.add(widget.controller.text));

  //   setState(() {});

  //   print(data.length);

  //}
  // void _presentYearPicker() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Select Year"),
  //         content: Container(
  //           // Need to use container to add size constraint.
  //           width: 300,
  //           height: 300,
  //           child: YearPicker(
  //             firstDate: DateTime(DateTime.now().year - 100, 1),
  //             lastDate: DateTime(DateTime.now().year + 100, 1),
  //             initialDate: DateTime.now(),
  //             // save the selected date to _selectedDate DateTime variable.
  //             // It's used to set the previous selected date when
  //             // re-showing the dialog.
  //             selectedDate: _selectedDate,
  //             onChanged: (DateTime dateTime) {
  //               print(_selectedDate);
  //               // close the dialog when year is selected.
  //               Navigator.pop(context);

  //               // Do something with the dateTime selected.
  //               // Remember that you need to use dateTime.year to get the year
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _presentMonthPicker() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Select Year"),
  //         content: Container(
  //           // Need to use container to add size constraint.
  //           width: 300,
  //           height: 300,
  //           child: MonthPicker(
  //             firstDate: DateTime(DateTime.now().month - 5, 1),
  //             lastDate: DateTime(DateTime.now().month + 5, 1),
  //             //selectedDate: DateTime.now().month,
  //             // save the selected date to _selectedDate DateTime variable.
  //             // It's used to set the previous selected date when
  //             // re-showing the dialog.
  //             selectedDate: _selectedDate,
  //             onChanged: (DateTime dateTime) {
  //               // close the dialog when year is selected.
  //               Navigator.pop(context);

  //               // Do something with the dateTime selected.
  //               // Remember that you need to use dateTime.year to get the year
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    //final hours = time.hour.toString().padLeft(2, '0'); //adds 0 infront of hours
    //final minutes = time.hour.toString().padLeft(2, '0'); //adds 0 infront of minutes
    final dynamic appBar = AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade100,
                    width: 3,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: mediaQuery.size.width * 0.2),
            const Text(
              'Bookings',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        child: TextButton(
          child: const Text(
            "Proceed",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (_selectedDate == null || time == null) {
              _onEmpty();
              print('empty');
              return;
            }
            Navigator.of(context).pushNamed(
              PaymentOptionScreen.routeName,
              arguments: {
                'id': _doctorId,
                'date': _selectedDate,
                'time': time,
              },
            );
            // _selectedDate = null;
            // time = null;
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(height: 30),
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
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
                    _selectedDate == null ? 'No Date Selected' : '${intl.DateFormat.yMMMMEEEEd().format(_selectedDate as DateTime)}',
                    style: const TextStyle(
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
                  label: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      _selectedDate == null ? "Select Appointment Date" : 'Date Selected',
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
            const SizedBox(
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
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Multiple Bookings'),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: _showMessage,
                  ),
                ],
              ),
            ),
          ])),
        ),
      ),
    );
  }
}
