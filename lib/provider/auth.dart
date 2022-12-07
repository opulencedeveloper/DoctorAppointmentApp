import "dart:convert";
import "dart:async";

import "package:flutter/widgets.dart";
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  String? myUserName;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null && _expiryDate!.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId.toString();
  }

  Future<void> createUsername(String useName) async {
    FirebaseFirestore.instance.collection('users').add({
      useName: useName,
    });
  }

  // Future<void> fetchAndSetUserName() async {
  //   final url = Uri.parse("https://my-doc-app-b9d24-default-rtdb.firebaseio.com/username/$userId.json?auth=$token");
  //   final response = await http.get(url);
  //   final extractedUserName = json.decode(response.body);
  //   print(json.decode(response.body));
  //   if (extractedUserName == null || extractedUserName.isEmpty) {
  //     print("fetch and set username is null");
  //     return;
  //   }
  //   String? fetchedUsername;
  //   extractedUserName.forEach((prodIId, prodDData) {
  //     fetchedUsername = prodDData["user"];
  //   });
  //   print("fetchedUsername");
  //   print(fetchedUsername);
  //   myUserName = fetchedUsername;
  //   notifyListeners();
  // }

  String? get useName {
    return myUserName;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
  //[String? usename]

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAxRn5Jc-e_r33PEIW6wdvwiFcG8epJaMA");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expiresIn"],
          ),
        ),
      );
      // if (urlSegment == 'signUp') {
      //   await FirebaseFirestore.instance.collection('users').doc(responseData["localId"]).set({
      //     'username': usename,
      //     'email': email,
      //   });
      // }
      _autoLogout();
      final prefs = await SharedPreferences.getInstance();

      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );

      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }

    notifyListeners();
    // print(json.decode(response.body));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'].toString();

    _userId = extractedUserData['userId'].toString();

    _expiryDate = expiryDate;

    notifyListeners();

    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    //prefs.remove('checker');
   // prefs.clear();

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  // bool get check {
  //   return showHome as bool;
  // }

  // bool? showHome;
  // Future<void> checker() async {
  //   print("showHome");
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final prefs = await SharedPreferences.getInstance();
  //   showHome = prefs.getBool('showHome') ?? false;
  //   notifyListeners();
  //   print(showHome);
  // }
}
