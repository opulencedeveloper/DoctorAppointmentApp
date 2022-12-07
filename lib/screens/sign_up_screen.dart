import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import "../provider/auth.dart";
import "../provider/password_obsure.dart";
import '../screens/sign_up_success_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback signUp;
  const SignUpScreen({Key? key, required this.signUp}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'username': '',
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
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData["email"] as String,
        _authData["password"] as String,
      );
      Provider.of<Auth>(context, listen: false).createUsername(
        _authData["username"] as String,
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

    setState(() {
      _isLoading = false;
    });
   
      
      Navigator.pushAndRemoveUntil(context,
MaterialPageRoute(builder: (context) => SignUpSuccessScreen()),  (Route<dynamic> route) => route.isFirst);
      
    
    //widget.signIn();
  }

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
                const SizedBox(height: 20),
                SizedBox(
                  height: 41,
                  child: GestureDetector(
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
                    onTap: widget.signUp,
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Create an account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const Text('Enter details to set up account', style: TextStyle(color: Colors.grey, fontSize: 16)),
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
                    controller: _passwordController,
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
                const Text('Confirm Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  ////height: constraints.maxHeight * 0.13,
                  child: Consumer<PasswordObsure>(builder: (_, obsure, _n) {
                    return TextFormField(
//controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obsure.confirmpasswordObsure();
                            // setState(() {
                            //   obscure = !obscure;
                            // });
                          },
                          child: obsure.confirmpasswordObsureMode ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: obsure.confirmpasswordObsureMode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
//controller: _passwordController,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value as String;
                      },
                    );
                  }),
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
                            "Sign up",
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
