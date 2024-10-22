import 'package:car_workshop/models/user_data_model.dart';
import 'package:car_workshop/providers/user_authentication_provider.dart';
import 'package:car_workshop/services/firebase_auth.dart';
import 'package:car_workshop/services/firebase_cloudstore.dart';
import 'package:car_workshop/utils/app_colors.dart';
import 'package:car_workshop/view/user_authentication/login_screen.dart';
import 'package:car_workshop/view_model/signup_authentication.dart';
import 'package:car_workshop/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.02,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Signup",
                    style: GoogleFonts.roboto(
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: AppColor().commonColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.043,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello there!",
                        style: GoogleFonts.roboto(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      Text(
                        "Welcome to Car workshop",
                        style: GoogleFonts.roboto(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.043,
                  ),
                  // ========= Text Input Field for Email and Password ============== //
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        shadowColor: AppColor().shadowColor,
                        color: Colors.white,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021,
                          ),
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 14,
                            ),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        shadowColor: AppColor().shadowColor,
                        color: Colors.white,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021,
                          ),
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 14,
                            ),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        shadowColor: AppColor().shadowColor,
                        color: Colors.white,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021,
                          ),
                          controller: cPasswordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 14,
                            ),
                            hintText: "Confirm your password",
                            hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        shadowColor: AppColor().shadowColor,
                        color: Colors.white,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021,
                          ),
                          controller: userNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 14,
                            ),
                            hintText: "Enter your Username",
                            hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "User role:",
                            style: GoogleFonts.roboto(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.white,
                            elevation: 4,
                            shadowColor: AppColor().shadowColor,
                            child: DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: EdgeInsets.only(
                                  left: 14,
                                ),
                                border: InputBorder.none,
                              ),
                              hintText: "Select role",
                              onSelected: (value) {
                                Provider.of<UserAuthenticationProvider>(context,
                                        listen: false)
                                    .roleSelection(value);
                                print(Provider.of<UserAuthenticationProvider>(
                                        context,
                                        listen: false)
                                    .selectedRole);
                              },
                              dropdownMenuEntries: [
                                DropdownMenuEntry(
                                    value: "Admin", label: "Admin"),
                                DropdownMenuEntry(
                                    value: "Mechanic", label: "Mechanic"),
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.043,
                      ),
                      // ----------- Login Button ------------ //
                      Material(
                        elevation: 4,
                        shadowColor: AppColor().shadowColor,
                        child: GestureDetector(
                          onTap: () async {
                            await SignupAuthentication().createUserAccount(
                              context,
                              emailController.text,
                              passwordController.text,
                              cPasswordController.text,
                              userNameController.text,
                            );
                          },
                          child: CommonButton(
                              title: Provider.of<UserAuthenticationProvider>(
                                              context)
                                          .isLoading ==
                                      true
                                  ? "Signing up.."
                                  : "Sign up"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.043,
                      ),
                      // ========= Sign up option ============== //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.roboto(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Log in",
                              style: GoogleFonts.roboto(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.w600,
                                color: AppColor().commonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
