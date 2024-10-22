import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view/user_authentication/signup_screen.dart';
import 'package:car_workshop/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                "assets/images/bg.jpg",
              ),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.38,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image:
                                AssetImage("assets/images/vehicle_service.jpg"),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.23,
                        left: MediaQuery.of(context).size.width * 0.027,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.32,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: AppColor().commonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Service",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage("assets/images/workshop.jpg"),
                            ),
                            borderRadius: BorderRadius.circular(65),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.32,
                          left: MediaQuery.of(context).size.width * 0.07,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.36,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: AppColor().commonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Workshop",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.023,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Regular maintenance by qualified mechanics is important to keep your car running smoothly and safely.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 5,
                    shadowColor: AppColor().shadowColor,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: CommonButton(title: "Let's Get Started"),
                    ),
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
