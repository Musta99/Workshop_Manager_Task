import 'package:car_workshop/providers/user_authentication_provider.dart';
import 'package:car_workshop/services/firebase_auth.dart';
import 'package:car_workshop/services/firebase_cloudstore.dart';
import 'package:car_workshop/view/user_authentication/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupAuthentication {
  // ----------- Account Creation -------------- //
  Future createUserAccount(
      BuildContext context, email, password, cPassword, userName) async {
    try {
      if (email.isEmpty ||
          password.isEmpty ||
          cPassword.isEmpty ||
          Provider.of<UserAuthenticationProvider>(context, listen: false)
                  .selectedRole ==
              "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Please fill all the fields",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            )));
      } else if (password != cPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Passwords do not match",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            )));
      } else {
        Provider.of<UserAuthenticationProvider>(context, listen: false)
            .showIndicator();
        await FirebaseAuthentication()
            .signupFirebaseAuth(email.trim(), password.trim());

        await FirebaseCloudStore().saveUserInfo(
          context,
          email,
          password,
          userName,
        );
        Provider.of<UserAuthenticationProvider>(context, listen: false)
            .hideIndicator();

        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Successfully Created",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            )));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            err.toString(),
            style: GoogleFonts.roboto(
              color: Colors.white,
            ),
          )));
    }
  }

  // ----------- User Log In -------------- //
  Future logInUser(BuildContext context, email, password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Please fill all the fields",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            )));
      } else {
        Provider.of<UserAuthenticationProvider>(context, listen: false)
            .showIndicator();
        await FirebaseAuthentication()
            .loginFirebaseAuth(email.trim(), password.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Successfully Logged in",
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            ),
          ),
        );
        Provider.of<UserAuthenticationProvider>(context, listen: false)
            .hideIndicator();
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            err.toString(),
            style: GoogleFonts.roboto(
              color: Colors.white,
            ),
          )));
    }
  }
}
