import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import "../provider/auth.dart";
import "../provider/password_obsure.dart";

import '../screens/sign_in_success_screen.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback signIn;
  const SignInScreen({Key? key, required this.signIn}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).signIn(
        _authData["email"] as String,
        _authData["password"] as String,
      );
    } on HttpException catch (error) {
//HttpException is from the file u created in the models folder, u caught and passed this exception in the auth.dart file
      var errorMessage = "Authentication failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is to a valid email address";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Could not find a user with that email";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid password";
      }
      _showErrorDialog(errorMessage);
       setState(() {
         _isLoading = false;
      });
      return;
    } catch (error) {
      const errorMessage = "Could not authenticate you, Please try again later. ";
      _showErrorDialog(errorMessage);
      setState(() {
      _isLoading = false;
       });
      return;
    }
    
    

Navigator.pushAndRemoveUntil(context,
MaterialPageRoute(builder: (context) => SignInSuccessScreen()),  (Route<dynamic> route) => route.isFirst);
      
    

    //widget.signIn();
    // Navigator.of(context).pop;
  }

  // bool? showHome;
  // Future<void> checker() async {
  //   print("showHome");
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final prefs = await SharedPreferences.getInstance();
  //   showHome = prefs.getString('set');
  //   print(showHome);
  // }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text("An Error Occurerd"),
                content: Text(
                  message,
                ),
                actions: [
                  ElevatedButton(
                      child: const Text("Okay"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      })
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                const Text('Sign in', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('New user?', style: TextStyle(fontSize: 16)),
                      TextButton(
                        child: const Text('Create new account', style: TextStyle(fontSize: 16)),
                        onPressed: widget.signIn,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Text('Email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextFormField(
                  // controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      // hintText: 'Mobile Number',
                      //labelText: 'Chexk',
                      //fillColor: Colors.white,
                      //filled: true,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value as String;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Consumer<PasswordObsure>(builder: (_, obsure, _n) {
                  return TextFormField(
                    // controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          obsure.passwordObsure();
                          // setState(() {
                          //   obscure = !obscure;
                          // });
                        },
                        child: obsure.passwordObsureMode
                            ? const Icon(Icons.visibility_off)
                            : const Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                    obscureText: obsure.passwordObsureMode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value as String;
                    },
                  );
                }),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Reset your password',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: theme.primary,
                  height: 50,
                  width: mediaQuery.size.width,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator(color: theme.secondary))
                      : TextButton(
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submit,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
