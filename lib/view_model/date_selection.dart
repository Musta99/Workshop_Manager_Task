import 'package:car_workshop/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateSelection {
  Future selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));

    if (selectedDate != null) {
      if (Provider.of<HomeScreenProvider>(context, listen: false)
              .initialFormat ==
          "Daily") {
        Provider.of<HomeScreenProvider>(context, listen: false)
            .changeDate(selectedDate);
      } else if (Provider.of<HomeScreenProvider>(context, listen: false)
              .initialFormat ==
          "Weekly") {
        Provider.of<HomeScreenProvider>(context, listen: false)
            .getWeek(selectedDate);
      } else {
        Provider.of<HomeScreenProvider>(context, listen: false)
            .getMonth(selectedDate);
      }
    }
  }
}
