import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view/home_screen/admin_view_screen/admin_home_screen.dart';
import 'package:car_workshop/view/user_authentication/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 6), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<HomeScreenProvider>(context, listen: false).allUserData();
    print(Provider.of<HomeScreenProvider>(context, listen: false)
        .userRole
        .toString());

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => AdminHomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: Image.asset(
                      "assets/images/gear.png",
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  );
                }),
            Text(
              "A Car Workshop Booking Application",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.023,
              ),
            )
          ],
        ),
      ),
    );
  }
}
