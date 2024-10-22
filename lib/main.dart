import 'package:car_workshop/firebase_options.dart';
import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/providers/user_authentication_provider.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/add_service_booking_screen.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/admin_home_screen.dart';
import 'package:car_workshop/view/landing_screen.dart';
import 'package:car_workshop/view/loading_screen.dart';
import 'package:car_workshop/view/user_authentication/signup_screen.dart';
import 'package:car_workshop/view_model/signup_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserAuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser != null
              ? LoadingScreen()
              : LandingScreen(),
        );
      },
    );
  }
}
