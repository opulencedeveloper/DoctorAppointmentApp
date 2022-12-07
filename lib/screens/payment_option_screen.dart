import 'package:flutter/material.dart';

import '../screens/credit_card_screen.dart';

class PaymentOptionScreen extends StatefulWidget {
  static const routeName = '/pay-route-name';
  const PaymentOptionScreen({Key? key}) : super(key: key);
  @override
  _PaymentOptionScreenState createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
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
      print('route');
    }
    _loadedInitData = true;
  }

  var index = 0;
  void _credit() {
    setState(() {
      index = 0;
    });
  }

  void _bankTf() {
    setState(() {
      index = 1;
    });
  }

  void _other() {
    setState(() {
      index = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
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
            SizedBox(width: mediaQuery.size.width * 0.14),
            const Text(
              "Payment options",
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
            Navigator.of(context).pushNamed(
              CreditCardScreen.routeName,
              arguments: {
                'id': _doctorId,
                'date': _selectedDate,
                'time': time,
              },
            );
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
              Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 3,
                  ),
                ),
                child: GestureDetector(
                  child: ListTile(
                    title: const Text(
                      'Credit or Debit Card',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Pay direct from your card through the app',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: index == 0 ? Icon(Icons.check_circle, color: theme.primary) : const SizedBox(),
                    onTap: _credit,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 3,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                    title: const Text(
                      'Bank Transfer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Transfer the money to the doctor\'s account directly',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: index == 1 ? Icon(Icons.check_circle, color: theme.primary) : const SizedBox(),
                    onTap: _bankTf),
              ),
              const SizedBox(height: 30),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 3,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                    title: const Text(
                      'Other Payment Methods',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: index == 2 ? Icon(Icons.check_circle, color: theme.primary) : const SizedBox(),
                    onTap: _other),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
