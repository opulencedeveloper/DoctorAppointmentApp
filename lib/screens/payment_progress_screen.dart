import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment-option-routeName';
  const PaymentScreen({Key? key}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var mySet = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        child: TextButton(
          child: Text(
            mySet ? "Cancel" : 'Continue',
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (mySet) {
              Navigator.of(context).pop();
              return;
            }
              
              Navigator.pushAndRemoveUntil(context,

                  MaterialPageRoute(builder: (context) => TabsScreen()),

                  (Route<dynamic> route) => route.isFirst

              );
              //Navigator.of(context).popUntil(ModalRoute.withName(TabsScreen.routeName));
           // Navigator.popUntil(context, (route) => route.settings.name == TabsScreen.routeName);

            // Navigator.of(context).pushNamed(
            //   CreditCardScreen.routeName,
            //   arguments: {
            //     'id': _doctorId,
            //     'date': _selectedDate,
            //     'time': time,
            //   },
            // );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.3,
              ),
              if (!mySet)
                Container(
                  alignment: Alignment.center,
                  height: 20,
                  child: const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                ),
              if (!mySet)
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text(
                    'Your payment is successful',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              if (mySet)
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/d7.png',
                    fit: BoxFit.fill,
                    scale: 2.5,
                  ),
                ),
              if (mySet) const SizedBox(height: 10),
              if (mySet)
                const Text(
                  'Payment in Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              if (mySet) const SizedBox(height: 20),
              if (mySet)
                const Text(
                  'Kindly wait for some seconds',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              if (mySet) const SizedBox(height: 20),
              if (mySet)
                TweenAnimationBuilder(
                  tween: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ),
                  duration: const Duration(seconds: 4),
                  builder: (context, value, _) => SizedBox(
                      width: 250,
                      //height: 200,
                      child: LinearProgressIndicator(
                        value: value as double,
                      )),
                  onEnd: () => setState(() => mySet = false),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
