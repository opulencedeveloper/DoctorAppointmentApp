import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import "../screens/auth_screen.dart";

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        //margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: TextButton(
          child: const Text(
            "Get Started",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', true);
            prefs.setString('set', 'setter');
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            //Provider.of<Auth>(context, listen: false).checker();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  theme.primary.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0,
                  3
                ],
              ),
            ),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                      Text(
                        'Book a Doctor\'s appointment',
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('with a simple click', style: TextStyle(color: Colors.grey)),
                    ])),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/images/intro.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
