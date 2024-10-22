import 'package:car_workshop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;

  MenuButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 4,
        shadowColor: AppColor().shadowColor,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                icon,
                size: MediaQuery.of(context).size.height * 0.021,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
