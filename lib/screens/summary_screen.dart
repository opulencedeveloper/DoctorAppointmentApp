import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

import '../provider/doctors.dart';
import '../screens/payment_progress_screen.dart';

class SummaryScreen extends StatefulWidget {
  static const routeName = 'summary-route-name';
  const SummaryScreen({Key? key}) : super(key: key);
  @override
  _SummaryScreenScreenState createState() => _SummaryScreenScreenState();
}

class _SummaryScreenScreenState extends State<SummaryScreen> {
  bool? checkedValue = false;
  var _loadedInitData = false;
  DateTime? _selectedDate;
  var _doctorId = '';
  var time = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _doctorId = routeArgs['id'] as String;
      _selectedDate = routeArgs['date'] as DateTime;
      time = routeArgs['time'] as String;
      print('need route');
    }
    _loadedInitData = true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    final loadedDoctor = Provider.of<Doctors>(context, listen: false).findById(_doctorId);
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
                    color: Colors.grey.shade200,
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
            SizedBox(width: mediaQuery.size.width * 0.25),
            const Text(
              "Summary",
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
            Navigator.of(context).pushNamed(PaymentScreen.routeName);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - 55,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        13,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: LayoutBuilder(builder: (ctx, constraints) {
                    return Column(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.7,
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          return Row(children: [
                            Container(
                              width: constraints.maxWidth * 0.33,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: FittedBox(
                                // alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    loadedDoctor.imageUrl,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.05,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: constraints.maxWidth * 0.08),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${loadedDoctor.firstName} ${loadedDoctor.lastName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      loadedDoctor.type,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Cambridge hospital, Lagos Nigeria",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]);
                        }),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.23,
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.phone, color: Colors.black),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.02,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.email, color: Colors.black),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.02,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.video_call, color: Colors.black),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.05,
                      ),
                    ]);
                  }),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    minLeadingWidth: 10,
                    contentPadding: const EdgeInsets.only(left: 2),
                    leading: const Icon(Icons.calendar_today, color: Colors.black),
                    title: Text(
                      'Date',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    subtitle: Text(
                      '${intl.DateFormat.yMMMMEEEEd().format(_selectedDate as DateTime)}',
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 30,
                  child: ListTile(
                    minLeadingWidth: 10,
                    contentPadding: const EdgeInsets.only(left: 2),
                    leading: const Icon(Icons.access_time_outlined, color: Colors.black),
                    title: Text(
                      'Time',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    subtitle: Text(
                      time,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 20,
                    child: Row(children: [
                      SizedBox(
                        width: 31,
                        child: Checkbox(
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Notify me one-hour to the appointment time",
                          style: const TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ])),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                    height: 20,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        'Total',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${loadedDoctor.fee.toString()}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
