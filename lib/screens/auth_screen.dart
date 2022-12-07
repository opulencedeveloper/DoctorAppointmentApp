import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './intro_screen.dart';
import "../provider/auth.dart";
import "./sign_in_screen.dart";
import "./sign_up_screen.dart";

enum AuthMode { SignUp, SignIn }

class AuthScreen extends StatefulWidget {
  static const routeName = "auth-screen";
  const AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.SignIn;
  void _signIn() {
    controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  final controller = PageController(initialPage: 0);
  void _signUp() {
    controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);

//  final _passwordController = TextEditingController();

    print("auth");
    return Scaffold(
      //backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: mediaQuery.size.height - mediaQuery.padding.top,
                padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  // borderRadius: const BorderRadius.only(
                  //   topRight: Radius.circular(15.0),
                  //   topLeft: Radius.circular(15.0),
                  // ),
                ),
                child: PageView(controller: controller, children: [
                  SignInScreen(signIn: _signUp),
                  SignUpScreen(signUp: _signIn)
                ])),
          ]),
        ),
      ),
    );
  }
}
