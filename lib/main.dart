import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/tabs_screen.dart';
import './screens/doctors_details_screen.dart';
import './screens/bookings_screen.dart';
import './screens/summary_screen.dart';
import './screens/payment_progress_screen.dart';
import './screens/video_call_screen.dart';
import './screens/sign_up_success_screen.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/payment_option_screen.dart';
import './screens/splash_screen.dart';
import './screens/intro_screen.dart';
import './screens/summary_screen.dart';
import './screens/payment_progress_screen.dart';
import './screens/credit_card_screen.dart';
import './provider/doctors.dart';
import './provider/auth.dart';
import './provider/password_obsure.dart';
import './provider/doctor_category.dart';
import './provider/profile_list.dart';

Future<void> main() async {
  print("runApp");
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp();
  runApp(MyApp(showHome: showHome));
}

// void main() {
//   print("runApp");
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PasswordObsure(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Doctors(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DoctorsCategories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProfileList(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Doctor App',
            theme: ThemeData(
              fontFamily: 'Lato',
              primaryColor: const Color(0xff009ABB),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xff009ABB),
                secondary: Colors.grey[50],
              ),
              appBarTheme: AppBarTheme(
                elevation: 0,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
                backgroundColor: Colors.grey[50],
              ),
            ),
            home: !showHome
                ? const IntroScreen()
                : auth.isAuth
                    ? const TabsScreen() //const TabsScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? const SplashScreen() : const AuthScreen(),
                      ),
            routes: {
              DoctorsDetailsScreen.routeName: (ctx) => const DoctorsDetailsScreen(),
              BookingsScreen.routeName: (ctx) => const BookingsScreen(),
              PaymentOptionScreen.routeName: (ctx) => const PaymentOptionScreen(),
              CreditCardScreen.routeName: (ctx) => const CreditCardScreen(),
              SummaryScreen.routeName: (ctx) => const SummaryScreen(),
              PaymentScreen.routeName: (ctx) => const PaymentScreen(),
              ChatScreen.routeName: (ctx) => const ChatScreen(),
              SignUpSuccessScreen.routeName: (ctx) => const SignUpSuccessScreen(),
              AuthScreen.routeName: (ctx) => const AuthScreen(),
              TabsScreen.routeName: (ctx) => const TabsScreen(),
              VideoCall.routeName: (ctx) => VideoCall(),
            }),
      ),
    );
  }
}
