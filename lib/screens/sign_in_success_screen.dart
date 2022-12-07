import 'package:flutter/material.dart';
import "./tabs_screen.dart";


class SignInSuccessScreen extends StatelessWidget {
  static const routeName = './sigin-success-route';
  const SignInSuccessScreen({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        child: TextButton(
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
MaterialPageRoute(builder: (context) => TabsScreen()),  (Route<dynamic> route) => route.isFirst);
          },
        ),
      ),body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.3,
              ),
              Container(
                alignment: Alignment.center,
                height: 170,
                child: Text(
                  'Login successful',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 20,
                child: const Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 80,
                  color: Colors.green,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}